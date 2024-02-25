unit Lizardia.Buildings;

interface

uses
  Lizardia.MapObject;

type
  TBuildingType = (btNone, btTownHall, btStorehouse, btBlacksmiths, btHouse,
    btFarm, btQuarry, btSawmill, btInn, btMill, btCoalMine, btSilverMine,
    btGoldMine, btIronMine, btBarracks);

type

  { TIndustry }

  TBuilding = class(TMapObject)
  private
    FBuildingType: TBuildingType;
  public
    constructor Create(const AName: string; const AX, AY: Integer);
    destructor Destroy; override;
    property BuildingType: TBuildingType read FBuildingType;
  end;

implementation

{ TBuilding }

constructor TBuilding.Create(const AName: string; const AX, AY: Integer);
begin
  inherited Create(AName, AX, AY);
  FBuildingType := btNone;
end;

destructor TBuilding.Destroy;
begin

  inherited;
end;

end.
