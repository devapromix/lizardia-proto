unit Lizardia.Resources;

interface

type
  TResourceEnum = (rsStones, rsTreeTrunks, rsTimber);

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
  FResource[rsStones].Name := 'Stones';
  FResource[rsTreeTrunks].Name := 'Tree Trunks';
  FResource[rsTimber].Name := 'Timber';
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
