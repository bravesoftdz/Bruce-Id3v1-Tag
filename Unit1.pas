unit Unit1;
                      {����:bruce 2012.10.1   QQ:654714226/1007136434}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, id3v1;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    ComboBox1: TComboBox;
    Edit7: TEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    LTitle: TLabel;
    LArtist: TLabel;
    LAlbum: TLabel;
    LYear: TLabel;
    LComment: TLabel;
    LTrack: TLabel;
    LGenre: TLabel;
    LFilePath: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ClearID3v1;
  end;

var
  Form1: TForm1;
  ID3v1: TID3v1;
  
implementation

{$R *.dfm}

procedure TForm1.ClearID3v1;
begin
 Edit1.Text:='';
 Edit2.Text:='';
 Edit3.Text:='';
 Edit4.Text:='';
 Edit5.Text:='';
 Edit6.Text:='';
 ComboBox1.ItemIndex:=0;
 ComboBox1.Enabled:=false;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
if not OpenDialog1.Execute then exit;
begin
 ID3v1.ReadFromFile(OpenDialog1.FileName);
 Edit1.Text:=ID3v1.Title;
 Edit2.Text:=ID3v1.Artist;
 Edit3.Text:=ID3v1.Album;
 Edit4.Text:=ID3v1.Year;
 Edit5.Text:=ID3v1.Comment;
 Edit6.Text:=IntToStr(ID3v1.Track);
 Edit7.Text:=OpenDialog1.FileName;
 if ID3v1.GenreID < MAX_MUSIC_GENRES then
 ComboBox1.ItemIndex := ID3v1.GenreID + 1;
 ComboBox1.Enabled:=true;
 Button2.Enabled:=true;
 Button3.Enabled:=true;
 Button4.Enabled:=true;
end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Iterator: Integer;
begin
    ID3v1 := TID3v1.Create;
  for Iterator := 0 to MAX_MUSIC_GENRES - 1 do
    ComboBox1.Items.Add(MusicGenre[Iterator]);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
If MessageDlg ('bruce��ʾ:'+#13+'��Ҫɾ��ID3�����?���ɾ���Ͳ��ָܻ���!',mtConfirmation,[mbOK,mbCancel],0)=mrOK then
begin
   if (FileExists(Edit7.Text)) and
    (ID3v1.RemoveFromFile(Edit7.Text)) then ClearID3v1
  else ShowMessage('����ɾ��ID3���: ' + Edit7.Text);
end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 ID3v1.ReadFromFile(Edit7.Text);
 Edit1.Text:=ID3v1.Artist;
 Edit2.Text:=ID3v1.Title;
 Edit3.Text:=ID3v1.Album;
 Edit4.Text:=ID3v1.Year;
 Edit5.Text:=ID3v1.Comment;
 Edit6.Text:=IntToStr(ID3v1.Track);
 ComboBox1.ItemIndex:=ID3v1.GenreID;
 ComboBox1.Enabled:=true;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  Value, Code: Integer;
begin
If MessageDlg ('��Ҫ�Ѹ��ĺ��ID3��ǩ��Ϣ���浽�ļ���?',mtConfirmation,[mbYes,mbCancel],0)=mrYes then begin
begin
 ID3v1.Artist:=Trim(Edit1.Text);
 ID3v1.Title:=Trim(Edit2.Text);               //����ID3
 ID3v1.Album:=Trim(Edit3.Text);
 ID3v1.Year:=Trim(Edit4.Text);
 ID3v1.Comment:=Trim(Edit5.Text);
 Val(Edit6.Text, Value, Code);
 if (Code = 0) and (Value > 0) then ID3v1.Track := Value
 else ID3v1.Track := 0;
 if ComboBox1.ItemIndex = 0 then ID3v1.GenreID := DEFAULT_GENRE
 else ID3v1.GenreID := ComboBox1.ItemIndex - 1;
 ID3v1.SaveToFile(Edit7.Text);
   end;
  end;
end;
 
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ID3v1.Free;
end;

end.
