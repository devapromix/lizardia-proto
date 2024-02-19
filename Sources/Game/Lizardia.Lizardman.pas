unit Lizardia.Lizardman;

interface

uses
  Lizardia.Entity;

type
  TLizardman = class(TEntity)
  private

  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TLizardman }

constructor TLizardman.Create;
begin
  inherited Create;
  SetLocation(1, 1);
end;

destructor TLizardman.Destroy;
begin

  inherited;
end;

end.
