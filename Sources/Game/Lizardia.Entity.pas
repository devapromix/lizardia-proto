unit Lizardia.Entity;

interface

type
  TLocation = record
    X: Integer;
    Y: Integer;
  end;

type
  TEntity = class(TObject)
  private
    FName: string;
    FLocation: TLocation;
  public
    constructor Create(const AName: string; const AX, AY: Integer); overload;
    constructor Create(const AX, AY: Integer); overload;
    constructor Create; overload;
    property Location: TLocation read FLocation write FLocation;
    procedure SetLocation(const AX, AY: Integer);
    function GetLocation: TLocation;
    function InLocation(const AX, AY: Integer): Boolean;
    property X: Integer read FLocation.X;
    property Y: Integer read FLocation.Y;
    property Name: string read FName;
  end;

implementation

{ TEntity }

constructor TEntity.Create(const AName: string; const AX, AY: Integer);
begin
  FLocation.X := AX;
  FLocation.Y := AY;
  FName := AName;
end;

constructor TEntity.Create(const AX, AY: Integer);
begin
  FLocation.X := AX;
  FLocation.Y := AY;
end;

constructor TEntity.Create;
begin
  FLocation.X := 0;
  FLocation.Y := 0;
end;

function TEntity.GetLocation: TLocation;
begin
  Result := FLocation;
end;

function TEntity.InLocation(const AX, AY: Integer): Boolean;
begin
  Result := (X = AX) and (Y = AY);
end;

procedure TEntity.SetLocation(const AX, AY: Integer);
begin
  FLocation.X := AX;
  FLocation.Y := AY;
end;

end.
