unit Lizardia.Lizardman.List;

interface

uses
  Lizardia.Entity,
  Lizardia.Lizardman,
  System.Generics.Collections,
  Lizardia.Lizardman.Factory;

type
  TLizardmanList = class(TObject)
  private
    FLizardmanFactory: TLizardmanFactory;
  public
    List: TObjectList<TLizardman>;
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure Add(const AX, AY: Integer);
  end;

implementation

{ TLizardmans }

uses
  Math,
  SysUtils,
  BearLibTerminal,
  Lizardia.Game,
  Lizardia.Scenes;

procedure TLizardmanList.Add(const AX, AY: Integer);
var
  LLizardman: TLizardman;
  LNum: Byte;
begin
  LNum := List.Count + 1;
  LLizardman := FLizardmanFactory.GenerateRandomLizardman;
  LLizardman.Name := 'Lizardman #' + IntToStr(LNum);
  List.Add(LLizardman);
end;

procedure TLizardmanList.Clear;
begin
  List.Clear;
end;

constructor TLizardmanList.Create;
begin
  FLizardmanFactory := TLizardmanFactory.Create;
  List := TObjectList<TLizardman>.Create();
end;

destructor TLizardmanList.Destroy;
begin
  List.Free;
  FLizardmanFactory.Free;
  inherited;
end;

end.
