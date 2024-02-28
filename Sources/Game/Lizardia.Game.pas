unit Lizardia.Game;

interface

uses
  Lizardia.Map,
  Lizardia.Pop,
  Lizardia.Tasks,
  Lizardia.Resources;

type
  TGame = class(TObject)
  private
    FMap: TMap;
    FIsDebug: Boolean;
    FTurn: Integer;
    FIsPause: Boolean;
    FIsGame: Boolean;
    FFullscreen: Boolean;
    FResource: TResource;
    FPop: TPop;
    FTasks: TTasks;
  public
    constructor Create;
    destructor Destroy; override;
    property IsDebug: Boolean read FIsDebug;
    property Resource: TResource read FResource write FResource;
    property Turn: Integer read FTurn;
    property Fullscreen: Boolean read FFullscreen write FFullscreen;
    property IsPause: Boolean read FIsPause write FIsPause;
    property IsGame: Boolean read FIsGame write FIsGame;
    property Pop: TPop read FPop write FPop;
    property Tasks: TTasks read FTasks write FTasks;
    property Map: TMap read FMap;
    procedure Refresh;
    procedure Step;
  end;

var
  Game: TGame;

implementation

uses
  SysUtils,
  Lizardia.Entity,
  BearLibTerminal,
  Lizardia.Lizardman.List;

{ TGame }

constructor TGame.Create;
var
  I: Integer;
begin
  FIsPause := True;
  FIsDebug := True;
  FFullscreen := False;
  for I := 1 to ParamCount do
  begin
    if (LowerCase(ParamStr(I)) = '-debug') then
      FIsDebug := True;
  end;
  FTasks := TTasks.Create;
  FPop := TPop.Create;
  FResource := TResource.Create;
  FMap := TMap.Create;
  FMap.Gen;
end;

procedure TGame.Refresh;
begin
  if Self.Fullscreen then
    terminal_set('window: fullscreen=true')
  else
    terminal_set('window: fullscreen=false');
end;

procedure TGame.Step;
begin
  if not IsGame or IsPause then
    Exit;
  Inc(FTurn);
  Game.Tasks.TryGetTask;
end;

destructor TGame.Destroy;
begin
  FTasks.Free;
  FPop.Free;
  FMap.Free;
  FResource.Free;
  inherited;
end;

end.
