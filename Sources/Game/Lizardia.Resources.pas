unit Lizardia.Resources;

interface

uses
  Lizardia.Buildings;

type
  TResourceEnum = (rsStone, rsCoal, rsIronOre, rsIron, rsSilverOre, rsSilver,
    rsGoldOre, rsGold, rsWood, rsPlanks, rsWool, rsRope, rsLeather, rsWater);

type
  TResourceRec = record
    Name: string;
    Value: Integer;
    BuildingType: TBuildingType;
  end;

type
  TResource = class(TObject)
  private
    FResource: array [TResourceEnum] of TResourceRec;
    procedure Add(const AResourceEnum: TResourceEnum; const AName: string;
      const ABuildingType: TBuildingType = btNone);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function GetResource(const AResourceEnum: TResourceEnum): TResourceRec;
    procedure ModifyResource(const AResourceEnum: TResourceEnum;
      const AValue: Integer = 1);
  end;

implementation

{ TResource }

procedure TResource.Add(const AResourceEnum: TResourceEnum; const AName: string;
  const ABuildingType: TBuildingType);
begin
  FResource[AResourceEnum].Name := AName;
  FResource[AResourceEnum].BuildingType := ABuildingType;
  FResource[AResourceEnum].Value := 0;
end;

procedure TResource.ModifyResource(const AResourceEnum: TResourceEnum;
  const AValue: Integer = 1);
begin
  FResource[AResourceEnum].Value := FResource[AResourceEnum].Value + AValue;
end;

procedure TResource.Clear;
begin
  Add(rsStone, 'Stone', btNone);
  Add(rsCoal, 'Coal', btNone);
  Add(rsIronOre, 'Iron Ore', btNone);
  Add(rsIron, 'Iron', btBlacksmiths);
  Add(rsSilverOre, 'Silver Ore', btNone);
  Add(rsSilver, 'Silver', btBlacksmiths);
  Add(rsGoldOre, 'Gold ore', btNone);
  Add(rsGold, 'Gold', btBlacksmiths);
  Add(rsWood, 'Wood', btNone);
  Add(rsPlanks, 'Planks', btWorkshop);
  Add(rsWool, 'Wool', btNone);
  Add(rsRope, 'Rope', btNone);
  Add(rsLeather, 'Leather', btNone);
  Add(rsWater, 'Water', btNone);
end;

constructor TResource.Create;
begin
  Self.Clear;
end;

destructor TResource.Destroy;
begin

  inherited;
end;

function TResource.GetResource(const AResourceEnum: TResourceEnum)
  : TResourceRec;
begin
  Result := FResource[AResourceEnum];
end;

end.
