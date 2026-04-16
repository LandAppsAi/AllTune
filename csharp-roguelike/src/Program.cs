using System.Text;

const int Width = 60;
const int Height = 24;

var game = new Game(Width, Height);
game.Run();

internal sealed class Game
{
    private readonly Dungeon _dungeon;
    private readonly Player _player;
    private readonly List<Monster> _monsters = new();
    private readonly Random _random = new();
    private int _floor = 1;
    private bool _running = true;
    private string _message = "Find the stairs '>' to descend. Use WASD or arrow keys.";

    public Game(int width, int height)
    {
        _dungeon = new Dungeon(width, height, _random);
        _player = new Player();
        StartFloor();
    }

    public void Run()
    {
        Console.CursorVisible = false;
        while (_running)
        {
            Draw();
            var key = Console.ReadKey(true);
            HandleInput(key);
            if (_running)
            {
                ResolveMonstersTurn();
                if (_player.Hp <= 0)
                {
                    _message = "You were defeated. Press Q to quit.";
                }
            }
        }
    }

    private void StartFloor()
    {
        _dungeon.Generate();
        _monsters.Clear();

        var start = _dungeon.GetRandomFloorTile();
        _player.X = start.X;
        _player.Y = start.Y;

        int monsterCount = 6 + _floor * 2;
        for (int i = 0; i < monsterCount; i++)
        {
            var pos = _dungeon.GetRandomFloorTile();
            if ((pos.X == _player.X && pos.Y == _player.Y) || _monsters.Any(m => m.X == pos.X && m.Y == pos.Y))
            {
                i--;
                continue;
            }

            _monsters.Add(new Monster
            {
                X = pos.X,
                Y = pos.Y,
                Hp = 4 + _floor,
                Attack = 1 + _floor / 2,
                Glyph = 'g'
            });
        }

        _message = $"Entered floor {_floor}. Eliminate threats and find stairs >";
    }

    private void HandleInput(ConsoleKeyInfo key)
    {
        if (key.Key is ConsoleKey.Q)
        {
            _running = false;
            return;
        }

        if (_player.Hp <= 0)
        {
            return;
        }

        int dx = 0;
        int dy = 0;

        switch (key.Key)
        {
            case ConsoleKey.W:
            case ConsoleKey.UpArrow:
                dy = -1;
                break;
            case ConsoleKey.S:
            case ConsoleKey.DownArrow:
                dy = 1;
                break;
            case ConsoleKey.A:
            case ConsoleKey.LeftArrow:
                dx = -1;
                break;
            case ConsoleKey.D:
            case ConsoleKey.RightArrow:
                dx = 1;
                break;
            default:
                return;
        }

        TryMovePlayer(dx, dy);
    }

    private void TryMovePlayer(int dx, int dy)
    {
        int nx = _player.X + dx;
        int ny = _player.Y + dy;

        var target = _monsters.FirstOrDefault(m => m.X == nx && m.Y == ny);
        if (target is not null)
        {
            target.Hp -= _player.Attack;
            _message = $"You hit the goblin for {_player.Attack}.";
            if (target.Hp <= 0)
            {
                _monsters.Remove(target);
                _message = "You slay the goblin!";
            }

            return;
        }

        if (!_dungeon.IsWalkable(nx, ny))
        {
            _message = "A wall blocks your path.";
            return;
        }

        _player.X = nx;
        _player.Y = ny;

        if (_dungeon.Stairs.X == nx && _dungeon.Stairs.Y == ny)
        {
            _floor++;
            _player.Hp = Math.Min(_player.MaxHp, _player.Hp + 4);
            _message = "You descend deeper and catch your breath (+4 HP).";
            StartFloor();
        }
    }

    private void ResolveMonstersTurn()
    {
        foreach (var monster in _monsters.ToList())
        {
            int dx = Math.Sign(_player.X - monster.X);
            int dy = Math.Sign(_player.Y - monster.Y);
            int dist = Math.Abs(_player.X - monster.X) + Math.Abs(_player.Y - monster.Y);

            if (dist == 1)
            {
                _player.Hp -= monster.Attack;
                _message = $"Goblin claws you for {monster.Attack}!";
                continue;
            }

            // Chase when close, wander otherwise.
            if (dist > 8)
            {
                dx = _random.Next(-1, 2);
                dy = _random.Next(-1, 2);
            }

            int nx = monster.X + dx;
            int ny = monster.Y + dy;

            if ((nx == _player.X && ny == _player.Y) ||
                _monsters.Any(m => !ReferenceEquals(m, monster) && m.X == nx && m.Y == ny) ||
                !_dungeon.IsWalkable(nx, ny))
            {
                continue;
            }

            monster.X = nx;
            monster.Y = ny;
        }
    }

    private void Draw()
    {
        var sb = new StringBuilder();
        sb.AppendLine($"RogueCrawler | Floor {_floor} | HP {_player.Hp}/{_player.MaxHp} | ATK {_player.Attack} | Monsters {_monsters.Count} | Q quit");

        for (int y = 0; y < _dungeon.Height; y++)
        {
            for (int x = 0; x < _dungeon.Width; x++)
            {
                if (_player.X == x && _player.Y == y)
                {
                    sb.Append('@');
                    continue;
                }

                var monster = _monsters.FirstOrDefault(m => m.X == x && m.Y == y);
                if (monster is not null)
                {
                    sb.Append(monster.Glyph);
                    continue;
                }

                if (_dungeon.Stairs.X == x && _dungeon.Stairs.Y == y)
                {
                    sb.Append('>');
                    continue;
                }

                sb.Append(_dungeon.Tiles[y, x]);
            }

            sb.AppendLine();
        }

        sb.AppendLine(_message);
        if (_player.Hp <= 0)
        {
            sb.AppendLine("Game over. Press Q to exit.");
        }

        Console.SetCursorPosition(0, 0);
        Console.Write(sb.ToString().PadRight((Console.WindowWidth * Console.WindowHeight) - 1));
    }
}

internal sealed class Dungeon
{
    private readonly Random _random;
    public int Width { get; }
    public int Height { get; }
    public char[,] Tiles { get; }
    public Point Stairs { get; private set; }

    public Dungeon(int width, int height, Random random)
    {
        Width = width;
        Height = height;
        _random = random;
        Tiles = new char[height, width];
    }

    public void Generate()
    {
        for (int y = 0; y < Height; y++)
        {
            for (int x = 0; x < Width; x++)
            {
                Tiles[y, x] = '#';
            }
        }

        var rooms = new List<Rect>();
        int roomCount = _random.Next(10, 16);

        for (int i = 0; i < roomCount; i++)
        {
            int w = _random.Next(5, 10);
            int h = _random.Next(4, 8);
            int x = _random.Next(1, Width - w - 1);
            int y = _random.Next(1, Height - h - 1);

            var room = new Rect(x, y, w, h);
            if (rooms.Any(r => r.Intersects(room)))
            {
                continue;
            }

            CarveRoom(room);
            if (rooms.Count > 0)
            {
                CarveTunnel(rooms[^1].Center, room.Center);
            }

            rooms.Add(room);
        }

        if (rooms.Count == 0)
        {
            // Fallback simple arena.
            var arena = new Rect(2, 2, Width - 4, Height - 4);
            CarveRoom(arena);
            rooms.Add(arena);
        }

        Stairs = rooms[^1].Center;
    }

    public bool IsWalkable(int x, int y)
    {
        return x > 0 && y > 0 && x < Width - 1 && y < Height - 1 && Tiles[y, x] == '.';
    }

    public Point GetRandomFloorTile()
    {
        while (true)
        {
            int x = _random.Next(1, Width - 1);
            int y = _random.Next(1, Height - 1);
            if (Tiles[y, x] == '.')
            {
                return new Point(x, y);
            }
        }
    }

    private void CarveRoom(Rect room)
    {
        for (int y = room.Y; y < room.Y + room.H; y++)
        {
            for (int x = room.X; x < room.X + room.W; x++)
            {
                Tiles[y, x] = '.';
            }
        }
    }

    private void CarveTunnel(Point from, Point to)
    {
        int x = from.X;
        int y = from.Y;

        while (x != to.X)
        {
            Tiles[y, x] = '.';
            x += Math.Sign(to.X - x);
        }

        while (y != to.Y)
        {
            Tiles[y, x] = '.';
            y += Math.Sign(to.Y - y);
        }
    }
}

internal sealed class Player
{
    public int X { get; set; }
    public int Y { get; set; }
    public int MaxHp { get; } = 20;
    public int Hp { get; set; } = 20;
    public int Attack { get; } = 3;
}

internal sealed class Monster
{
    public int X { get; set; }
    public int Y { get; set; }
    public int Hp { get; set; }
    public int Attack { get; set; }
    public char Glyph { get; set; }
}

internal readonly record struct Point(int X, int Y);

internal readonly record struct Rect(int X, int Y, int W, int H)
{
    public Point Center => new(X + W / 2, Y + H / 2);

    public bool Intersects(Rect other)
    {
        return X <= other.X + other.W && X + W >= other.X &&
               Y <= other.Y + other.H && Y + H >= other.Y;
    }
}
