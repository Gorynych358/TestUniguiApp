unit Model.BaseEntity;

interface

uses SysUtils, Model.IEntity;

type
  TBaseEntity = class(TInterfacedObject, IEntityInterface)
  private
    FName: String;
    FID: String;
    FCaption: String;

    procedure SetID(const AID:String);
    procedure SetName(const AName:String);
    procedure SetCaption(const ACaption:String);
  public
    property ID:String read FID write SetID;
    property Name:String read FName write SetName;
    property Caption:String read FCaption write SetCaption;
  end;
implementation

{ BaseEntity }

procedure TBaseEntity.SetCaption(const ACaption: String);
begin
  if Trim(ACaption) <> ''  then
    FCaption:=Trim(ACaption);
end;

procedure TBaseEntity.SetID(const AID: String);
begin
  if Trim(AID) <> ''  then
    FID:=Trim(AID);
end;

procedure TBaseEntity.SetName(const AName: String);
begin
  if Trim(AName) <> '' then
    FName:=Trim(AName);
end;

end.
