unit Lizardia.Game;

interface

uses
  Lizardia.Map;

type
  TGame = class(TObject)
  private
    FMap: TMap;
    FIsDebug: Boolean;
    FTurn: Integer;
    FIsPause: Boolean;
    FIsGame: Boolean;
    FFullscreen: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property IsDebug: Boolean read FIsDebug;
    property Turn: Integer read FTurn;
	property Fullscreen: Boolean read FFullscreen write FFullscreen;
    property IsPause: Boolean read FIsPause write FIsPause;
    property IsGame: Boolean read FIsGame write FIsGame;
    property Map: TMap read FMap;
	procedure Refresh;
  end;

var
  Game: TGame;

implementation

uses
  SysUtils,
  Lizardia.Entity,
  BearLibTerminal;

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

destructor TGame.Destroy;
begin
  FMap.Free;
  inherited;
end;

end.
