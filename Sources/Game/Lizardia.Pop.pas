unit Lizardia.Pop;

interface

type
  TPop = class(TObject)
  private
    FMax: Byte;
    FValue: Byte;
  public
    constructor Create;
    destructor Destroy; override;
    property Value: Byte read FValue write FValue;
    property Max: Byte read FMax write FMax;
    function ToString: string;
  end;

implementation

{ TPop }

constructor TPop.Create;
begin
  FValue := 3;
  FMax := 3;
end;

destructor TPop.Destroy;
begin

  inherited;
end;

function TPop.ToString: string;
begin

end;

end.