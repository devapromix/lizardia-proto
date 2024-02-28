unit Lizardia.Lizardman;

interface

uses
  Lizardia.Entity,
  Lizardia.Tasks;

type
  TLizardman = class(TEntity)
  private
    FName: string;
    FTask: TTask;
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read FName write FName;
    property Task: TTask read FTask write FTask;
  end;

implementation

{ TLizardman }



constructor TLizardman.Create;
begin
  inherited Create;
  SetLocation(1, 1);
  FTask.TaskType := ttNone;
  FTask.Turns := 0;
end;

destructor TLizardman.Destroy;
begin

  inherited;
end;

end.
