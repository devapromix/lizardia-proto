﻿unit Lizardia.Tasks;

interface

uses
  System.Generics.Collections,
  Lizardia.Resources;

type
  TTaskType = (ttNone, ttMakePlanks, ttDrawWater, ttMineStones, ttCutTree);

type
  TTask = record
    Name: string;
    TaskType: TTaskType;
    Turns: Integer;
    ResourceEnum: TResourceEnum;
    Count: Integer;
    procedure Turn;
    procedure Clear;
  end;

type
  TTasks = class(TObject)
  private
    FQueue: TArray<TTask>;
  public
    function IsTask: Boolean;
    procedure TryGetTask;
    procedure Add(const ATaskType: TTaskType);
    function GetCount(const ATaskType: TTaskType): Integer;
  end;

const
  TaskBase: array [TTaskType] of TTask = (
    //
    (Name: 'Doing nothing'; TaskType: ttNone; Turns: 0; ResourceEnum: rsNone;
    Count: 0),
    //
    (Name: 'Working'; TaskType: ttMakePlanks; Turns: 300;
    ResourceEnum: rsPlanks; Count: 3),
    //
    (Name: 'Working'; TaskType: ttDrawWater; Turns: 50; ResourceEnum: rsWater;
    Count: 1),
    //
    (Name: 'Digging'; TaskType: ttMineStones; Turns: 500;
    ResourceEnum: rsStones; Count: 1),
    //
    (Name: 'Cut tree'; TaskType: ttCutTree; Turns: 150;
    ResourceEnum: rsWood; Count: 1)
    //
    );

implementation

uses
  Lizardia.Game;

{ TTask }

procedure TTask.Clear;
begin
  Self.TaskType := ttNone;
end;

procedure TTask.Turn;
begin
  Self.Turns := Self.Turns - 1;
end;

{ TTasks }

procedure TTasks.Add(const ATaskType: TTaskType);
begin
  SetLength(FQueue, Length(FQueue) + 1);
  FQueue[Length(FQueue) - 1].TaskType := ATaskType;
  FQueue[Length(FQueue) - 1].Turns := TaskBase[ATaskType].Turns;
end;

function TTasks.GetCount(const ATaskType: TTaskType): Integer;
var
  I, LCount: Integer;
begin
  LCount := 0;
  for I := 0 to Length(FQueue) - 1 do
    if (FQueue[I].TaskType = ATaskType) then
      Inc(LCount);
  Result := LCount;
end;

function TTasks.IsTask: Boolean;
begin
  Result := Length(FQueue) > 0;
end;

procedure TTasks.TryGetTask;
var
  I: Integer;

  procedure AddResource(const AResourceEnum: TResourceEnum;
    const AValue: Cardinal = 1);
  begin
    Game.Resource.AddResource(AResourceEnum, AValue);
    Game.Map.LizardmanList.List[I].Task.Clear;
  end;

begin
  with Game.Map.LizardmanList do
    for I := 0 to List.Count - 1 do
    begin
      if IsTask and (List[I].Task.TaskType = ttNone) then
      begin
        List[I].Task := FQueue[Length(FQueue) - 1];
        SetLength(FQueue, Length(FQueue) - 1);
      end;
      if List[I].Task.Turns > 0 then
        List[I].Task.Turn;
      if (List[I].Task.Turns = 0) and (List[I].Task.TaskType <> ttNone) then
        AddResource(TaskBase[List[I].Task.TaskType].ResourceEnum,
          TaskBase[List[I].Task.TaskType].Count);
    end;
end;

end.
