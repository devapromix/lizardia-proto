unit Lizardia.Map;

interface

uses
  Lizardia.Entity,
  Lizardia.Buildings,
  Lizardia.Lizardman.List;

type
  TTiles = (
    // Land
    tlGrass, tlDirt, tlSand, tlTree, tlRock, tlWater,
    // Buildings
    tlTownHall, tlStorehouse, tlInsulae, tlWorkshop, tlWell, tlQuarry,
    tlSawmill);

const
  LandTiles = [tlGrass, tlDirt, tlSand, tlTree];

type
  TTile = record
    Name: string;
    Tile: Char;
    Color: string;
    BkColor: string;
  end;

const
  Tile: array [TTiles] of TTile = (
    //
    (Name: 'Grass'; Tile: '"'; Color: 'green'; BkColor: 'darkest green'),
    //
    (Name: 'Dirt'; Tile: ':'; Color: 'dark yellow'; BkColor: 'darkest yellow'),
    //
    (Name: 'Sand'; Tile: ':'; Color: 'white'; BkColor: 'darkest yellow'),
    //
    (Name: 'Tree'; Tile: 'T'; Color: 'green'; BkColor: 'darkest green'),
    //
    (Name: 'Rock'; Tile: '#'; Color: 'dark gray'; BkColor: 'darkest grey'),
    //
    (Name: 'Water'; Tile: '='; Color: 'blue'; BkColor: 'darkest blue'),
    //
    (Name: 'Town Hall'; Tile: 'T'; Color: 'light yellow';
    BkColor: 'darkest yellow'),
    //
    (Name: 'Storehouse'; Tile: 'S'; Color: 'light yellow';
    BkColor: 'darkest yellow'),
    //
    (Name: 'Tiny Insulae'; Tile: 'H'; Color: 'light yellow';
    BkColor: 'darkest yellow'),
    //
    (Name: 'Workshop'; Tile: 'W'; Color: 'light yellow';
    BkColor: 'darkest yellow'),
    //
    (Name: 'Well'; Tile: 'U'; Color: 'light blue'; BkColor: 'darkest yellow'),
    //
    (Name: 'Quarry'; Tile: 'Q'; Color: 'light yellow';
    BkColor: 'darkest yellow'),
    //
    (Name: 'Sawmill'; Tile: 'M'; Color: 'light yellow';
    BkColor: 'darkest yellow')
    //
    );

type
  TCell = record
    Tile: TTile;
  end;

type

  { TMap }

  TMap = class(TObject)
  private
    FWidth: Word;
    FTop: Word;
    FHeight: Word;
    FLeft: Word;
    Cell: array of array of TTiles;
    FLizardmanList: TLizardmanList;
    FSpawn: TLocation;
    procedure Resize;
    procedure AddSpot(const AX, AY: Integer; const ATile: TTiles;
      const Max: Integer = 300);
  public
    Building: array of TBuilding;
    constructor Create;
    destructor Destroy; override;
    property Top: Word read FTop write FTop;
    property Left: Word read FLeft write FLeft;
    property Height: Word read FHeight;
    property Width: Word read FWidth;
    procedure Clear;
    procedure Draw(const AWidth, AHeight: Integer);
    procedure Gen;
    function GetTile(const AX, AY: Integer): TTiles; overload;
    function GetTile: TTiles; overload;
    property LizardmanList: TLizardmanList read FLizardmanList;
    property Spawn: TLocation read FSpawn;
    procedure PlaceBuilding(const ABuildingType: TBuildingType;
      const AX, AY: Integer);
    function GetCurrentBuilding(const AX, AY: Integer): Integer;
  end;

implementation

uses
  Math,
  SysUtils,
  BearLibTerminal,
  Lizardia.Game;

{ TMap }

function TMap.GetCurrentBuilding(const AX, AY: Integer): Integer;
var
  LBuildingIndex: Integer;
begin
  Result := -1;
  for LBuildingIndex := 0 to Length(Building) - 1 do
    if Building[LBuildingIndex].InLocation(AX, AY) then
      Exit(LBuildingIndex);
end;

procedure TMap.AddSpot(const AX, AY: Integer; const ATile: TTiles;
  const Max: Integer = 300);
var
  VSize, I, VX, VY: Integer;
begin
  VX := AX;
  VY := AY;
  VSize := RandomRange(100, Max) * 10;
  for I := 0 to VSize do
  begin
    if (RandomRange(0, 6) = 0) and (VX > 0) then
    begin
      VX := VX - 1;
      Cell[VX][VY] := ATile;
    end;
    if (RandomRange(0, 6) = 0) and (VX < FWidth - 1) then
    begin
      VX := VX + 1;
      Cell[VX][VY] := ATile;
    end;
    if (RandomRange(0, 6) = 0) and (VY > 0) then
    begin
      VY := VY - 1;
      Cell[VX][VY] := ATile;
    end;
    if (RandomRange(0, 6) = 0) and (VY < FHeight - 1) then
    begin
      VY := VY + 1;
      Cell[VX][VY] := ATile;
    end;
  end;
end;

procedure TMap.PlaceBuilding(const ABuildingType: TBuildingType;
  const AX, AY: Integer);
begin
  case ABuildingType of
    btTownHall:
      begin
        Cell[AX][AY] := tlTownHall;
        SetLength(Building, Length(Building) + 1);
        Building[Length(Building) - 1] :=
          TBuilding.Create(ABuildingType, AX, AY);
      end;
    btStorehouse:
      begin
        Cell[AX][AY] := tlStorehouse;
        SetLength(Building, Length(Building) + 1);
        Building[Length(Building) - 1] :=
          TBuilding.Create(ABuildingType, AX, AY);
      end;
    btInsulae:
      begin
        Cell[AX][AY] := tlInsulae;
        SetLength(Building, Length(Building) + 1);
        Building[Length(Building) - 1] :=
          TBuilding.Create(ABuildingType, AX, AY);
      end;
  end;
end;

procedure TMap.Clear;
var
  LBuildingIndex: Integer;
  X, Y: Integer;
begin
  Resize;
  for Y := 0 to FHeight - 1 do
    for X := 0 to FWidth - 1 do
      Cell[X][Y] := tlGrass;
  FLizardmanList.Clear;
  for LBuildingIndex := 0 to Length(Building) - 1 do
    Building[LBuildingIndex].Free;
  SetLength(Building, 0);
end;

constructor TMap.Create;
begin
  FLizardmanList := TLizardmanList.Create;
  Resize;
end;

destructor TMap.Destroy;
var
  LBuildingIndex: Integer;
begin
  for LBuildingIndex := 0 to Length(Building) - 1 do
    Building[LBuildingIndex].Free;
  SetLength(Building, 0);
  FLizardmanList.Free;
  inherited;
end;

procedure TMap.Draw(const AWidth, AHeight: Integer);
var
  X, Y: Integer;
  F: Boolean;
begin
  terminal_layer(0);
  for Y := 0 to AHeight - 1 do
    for X := 0 to AWidth - 1 do
    begin
      terminal_bkcolor(Tile[Cell[Left + X][Top + Y]].BkColor);
      terminal_color(Tile[Cell[Left + X][Top + Y]].Color);
      terminal_put(X, Y, Tile[Cell[Left + X][Top + Y]].Tile);
    end;
  terminal_bkcolor('darkest gray');
  terminal_color('white');
end;

procedure TMap.Gen;
var
  I, J, X, Y, L: Integer;
var
  LBuildingType: TBuildingType;
begin
  Clear;
  //
  L := Math.RandomRange(FWidth div 3, FWidth div 2);
  //
  for I := 0 to 29 do
  begin
    X := Math.RandomRange(0, FWidth - 1);
    Y := Math.RandomRange(0, FHeight - 1);
    case RandomRange(0, 5) of
      0 .. 1:
        AddSpot(X, Y, tlDirt);
      2 .. 3:
        AddSpot(X, Y, tlSand);
      4:
        if Y < L then
          AddSpot(X, Y, tlWater, 400);
    else
      AddSpot(X, Y, tlTree, 400);
    end;
  end;
  //
  for Y := 0 to FHeight - 1 do
  begin
    for X := 0 to FWidth - 1 do
    begin
      case Math.RandomRange(0, 25) of
        0 .. 3:
          if (Cell[X][Y] <> tlWater) then
            if (Cell[X][Y] = tlGrass) or (Cell[X][Y] = tlDirt) then
              Cell[X][Y] := tlTree;
      end;
    end;
  end;
  //
  repeat
    X := Math.RandomRange(FWidth div 4, (FWidth div 4) * 3);
    Y := Math.RandomRange(FHeight div 4, (FHeight div 4) * 3);
  until (Cell[X][Y] in LandTiles);
  FSpawn.X := X;
  FSpawn.Y := Y;
  for I := 0 to 2 do // max 20
    FLizardmanList.Add(X, Y);
  for LBuildingType := btTownHall to btInsulae do
  begin
    repeat
      X := Math.RandomRange(-3, 4) + FSpawn.X;
      Y := Math.RandomRange(-3, 4) + FSpawn.Y;
    until (X <> 0) and (Y <> 0) and (Cell[X][Y] in LandTiles);
    PlaceBuilding(LBuildingType, X, Y);
  end;
end;

function TMap.GetTile: TTiles;
var
  LX, LY: Integer;
begin
  Result := tlGrass;
  LX := EnsureRange(Left + terminal_state(TK_MOUSE_X), 0, FWidth);
  LY := EnsureRange(Top + terminal_state(TK_MOUSE_Y), 0, FHeight);
  Result := Cell[LX][LY];
end;

function TMap.GetTile(const AX, AY: Integer): TTiles;
begin
  Result := Cell[AX][AY];
end;

procedure TMap.Resize;
begin
  FLeft := 0;
  FWidth := 160;
  FHeight := 160;
  SetLength(Cell, FWidth, FHeight);
end;

end.
