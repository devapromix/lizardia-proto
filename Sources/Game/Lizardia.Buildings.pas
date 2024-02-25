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
    constructor Create(const ABuildingType: TBuildingType;
      const AX, AY: Integer);
    destructor Destroy; override;
    property BuildingType: TBuildingType read FBuildingType;
  end;

implementation

{ TBuilding }

constructor TBuilding.Create(const ABuildingType: TBuildingType;
  const AX, AY: Integer);
var
  LName: string;
begin
  inherited Create(LName, AX, AY);
  case ABuildingType of
    btTownHall:
      begin
        LName := 'Town Hall';
        FBuildingType := ABuildingType;
      end;
    btStorehouse:
      begin
        LName := 'Storehouse';
        FBuildingType := ABuildingType;
      end;
  else
    begin
      LName := '';
      FBuildingType := btNone;
    end;
  end;
end;

destructor TBuilding.Destroy;
begin

  inherited;
end;

end.
