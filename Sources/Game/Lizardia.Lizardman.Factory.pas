unit Lizardia.Lizardman.Factory;

interface

uses
  Lizardia.Lizardman;

type
  TLizardmanFactory = class(TObject)
  private

  public
    constructor Create;
    destructor Destroy; override;
    function GenerateRandomLizardman: TLizardman;
  end;

implementation

{ TLizardmanFactory }

constructor TLizardmanFactory.Create;
begin

end;

destructor TLizardmanFactory.Destroy;
begin

  inherited;
end;

function TLizardmanFactory.GenerateRandomLizardman: TLizardman;
var
  Lizardman: TLizardman;
begin
  Lizardman := TLizardman.Create;
  Result := Lizardman;
end;

end.
