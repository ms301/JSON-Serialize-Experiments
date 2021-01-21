program IgnoreIfNil;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.Json.Types,
  System.Json.Serializers,
  System.SysUtils, System.Rtti;

type

  TtgKeyboardButtonPollType = class
  private
    [JsonName('type')]
    FType: string;
  public
    { TODO -oOwner -cGeneral : change to enum }
    property &Type: string read FType write FType;
  end;

  TtgKeyboardButton = class
  private
    [JsonName('text')]
    FText: string;
    [JsonName('request_contact')]
    FRequestContact: Boolean;
    [JsonName('request_location')]
    FRequestLocation: Boolean;
    [JsonName('request_poll')]
    FRequestPoll: TtgKeyboardButtonPollType;
    constructor Create;
  public
    /// <summary>
    /// Text of the button. If none of the optional fields are used, it will be sent as
    /// a message when the button is pressed
    /// </summary>
    property Text: string read FText write FText;
    /// <summary>
    /// Optional. If True, the user's phone number will be sent as a contact when the
    /// button is pressed. Available in private chats only
    /// </summary>
    property RequestContact: Boolean read FRequestContact write FRequestContact;
    /// <summary>
    /// Optional. If True, the user's current location will be sent when the button is
    /// pressed. Available in private chats only
    /// </summary>
    property RequestLocation: Boolean read FRequestLocation write FRequestLocation;
    /// <summary>
    /// Optional. If specified, the user will be asked to create a poll and send it to
    /// the bot when the button is pressed. Available in private chats only
    /// </summary>
    property RequestPoll: TtgKeyboardButtonPollType read FRequestPoll write FRequestPoll;
  end;

  TJsonDefaultContractResolverAndIgnoreIfNil = class(TJsonDefaultContractResolver)

  protected
    function ShouldIncludeMember(const AMember: TRttiMember; AMemberSerialization: TJsonMemberSerialization)
      : Boolean; override;
  end;

procedure Main;
var
  lJson: TJsonSerializer;
  lBtn: TtgKeyboardButton;
  lJsonString: string;
begin
  lJson := TJsonSerializer.Create;
  lBtn := TtgKeyboardButton.Create;
  try
    lJson.Formatting := TJsonFormatting.Indented;
    lJson.ContractResolver := TJsonDefaultContractResolverAndIgnoreIfNil.Create();
    lJsonString := lJson.Serialize<TtgKeyboardButton>(lBtn);
    Writeln(lJsonString);
  finally
    lBtn.Free;
    lJson.Free;
  end;
end;

{ TtgKeyboardButton }

constructor TtgKeyboardButton.Create;
begin
  FText := '';
  FRequestContact := False;
  FRequestLocation := False;
  FRequestPoll := nil;
end;

{ TJsonDefaultContractResolverAndIgnoreIfNil }

function TJsonDefaultContractResolverAndIgnoreIfNil.ShouldIncludeMember(const AMember: TRttiMember;
  AMemberSerialization: TJsonMemberSerialization): Boolean;
var
  lField: TRttiField;
begin
  if AMember is TRttiField then
  begin
    lField := TRttiField(AMember);

  end;
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    Main;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
