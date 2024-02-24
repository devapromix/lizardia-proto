unit Lizardia.Resources;

interface

type
  TResourceEnum = (rsStone, rsWood, rsPlanks, rsWool, rsRope, rsLeather);

type
  TResourceRec = record
    Name: string;
    Value: Integer;
  end;

type
  TResource = class(TObject)
  private
    FResource: array [TResourceEnum] of TResourceRec;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function GetResource(const AResourceEnum: TResourceEnum): TResourceRec;
  end;

implementation

{ TResource }

procedure TResource.Clear;
var
  LResourceEnum: TResourceEnum;
begin
  FResource[rsStone].Name := 'Stone';
  FResource[rsWood].Name := 'Wood';
  FResource[rsPlanks].Name := 'Planks';
  FResource[rsWool].Name := 'Wool';
  FResource[rsRope].Name := 'Rope';
  FResource[rsLeather].Name := 'Leather';
  FResource[rs].Name := '';
  for LResourceEnum := Low(TResourceEnum) to High(TResourceEnum) do
    FResource[LResourceEnum].Value := 0;
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
