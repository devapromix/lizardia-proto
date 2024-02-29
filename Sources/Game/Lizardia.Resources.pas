unit Lizardia.Resources;

interface

uses
  Lizardia.Buildings;

type
  TResourceEnum = (rsNone, rsStones, rsCoal, rsIronOre, rsIron, rsSilverOre,
    rsSilver, rsGoldOre, rsGold, rsWood, rsPlanks, rsWool, rsRope, rsLeather,
    rsWater, rsFood);

type
  TResourceRec = record
    Name: string;
    BuildingType: TBuildingType;
    Value: Cardinal;
  end;

const
  ResourceBase: array [TResourceEnum] of TResourceRec = (
    //
    (Name: ''; BuildingType: btNone;),
    //
    (Name: 'Stones'; BuildingType: btNone;),
    //
    (Name: 'Coal'; BuildingType: btNone;),
    //
    (Name: 'IronOre'; BuildingType: btNone;),
    //
    (Name: 'Iron'; BuildingType: btBlacksmiths;),
    //
    (Name: 'Silver Ore'; BuildingType: btNone;),
    //
    (Name: 'Silver'; BuildingType: btBlacksmiths;),
    //
    (Name: 'Gold ore'; BuildingType: btNone;),
    //
    (Name: 'Gold'; BuildingType: btBlacksmiths;),
    //
    (Name: 'Wood'; BuildingType: btNone;),
    //
    (Name: 'Planks'; BuildingType: btWorkshop;),
    //
    (Name: 'Wool'; BuildingType: btNone;),
    //
    (Name: 'Rope'; BuildingType: btNone;),
    //
    (Name: 'Leather'; BuildingType: btNone;),
    //
    (Name: 'Water'; BuildingType: btNone;),
    //
    (Name: 'Food'; BuildingType: btNone;)
    //
    // (Name: ''; BuildingType: rs;)
    //
    );

type
  TResource = class(TObject)
  private
    FResource: array [TResourceEnum] of TResourceRec;
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

procedure TResource.AddResource(const AResourceEnum: TResourceEnum;
  const AValue: Cardinal = 1);
begin
  FResource[AResourceEnum].Value := FResource[AResourceEnum].Value + AValue;
end;

procedure TResource.Clear;
var
  LResourceEnum: TResourceEnum;
begin
  for LResourceEnum := Low(TResourceEnum) to High(TResourceEnum) do
    with FResource[LResourceEnum] do
    begin
      Name := ResourceBase[LResourceEnum].Name;
      BuildingType := ResourceBase[LResourceEnum].BuildingType;
      Value := 0;
    end;
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
