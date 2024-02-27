unit Lizardia.Resources;

interface

uses
  Lizardia.Buildings;

type
  TResourceEnum = (rsStones, rsCoal, rsIronOre, rsIron, rsSilverOre, rsSilver,
    rsGoldOre, rsGold, rsWood, rsPlanks, rsWool, rsRope, rsLeather,
    rsWater, rsFood);

type
  TResourceRec = record
    Name: string;
    Value: Cardinal;
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
    procedure AddResource(const AResourceEnum: TResourceEnum;
      const AValue: Cardinal = 1);
    function DelResource(const AResourceEnum: TResourceEnum;
      const AValue: Cardinal = 1): Boolean;
    function HasResource(const AResourceEnum: TResourceEnum;
      const AValue: Cardinal = 1): Boolean;
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

procedure TResource.AddResource(const AResourceEnum: TResourceEnum;
  const AValue: Cardinal = 1);
begin
  FResource[AResourceEnum].Value := FResource[AResourceEnum].Value + AValue;
end;

procedure TResource.Clear;
begin
  Add(rsStones, 'Stones', btNone);
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
  Add(rsFood, 'Food', btNone);
end;

constructor TResource.Create;
begin
  Self.Clear;
end;

function TResource.DelResource(const AResourceEnum: TResourceEnum;
  const AValue: Cardinal): Boolean;
begin
  Result := False;
  if HasResource(AResourceEnum, AValue) then
  begin
    FResource[AResourceEnum].Value := FResource[AResourceEnum].Value - AValue;
    Result := True;
  end;
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

function TResource.HasResource(const AResourceEnum: TResourceEnum;
  const AValue: Cardinal): Boolean;
begin
  Result := FResource[AResourceEnum].Value >= AValue;
end;

end.
