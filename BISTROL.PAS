{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/alimbase)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Program BISTROL;

Uses {$IFDEF FPC}
      DOS,Crt,PtcGraph,PtcCrt,PtcMouse
     {$ELSE}
      DOS,Crt,Graph
     {$ENDIF};

Const
 HeightScreen=480;

Var
 SourceCSV:Text;
 I,PosField,WidthBar,X,NextX:Integer;
 FileName,CurrLine,CurrWord,CurrDate:String;
 CurrType:Byte;
 DateArray:Array[0..365]of DateTime;
 TypeArray:Array[0..365]of Byte;
 NumRecord:Integer;

Function StrToUpper(S:String):String;
Var
 I:Byte;
Begin
 For I:=1 to Length(S)do Begin
  If S[I] in['a'..'z']Then S[I]:=Chr(Ord(S[I])-32);
 End;
 StrToUpper:=S;
End;

Function IntToStr(Value:Integer):String;
Var
 S:String;
Begin
 Str(Value,S);
 IntToStr:=S;
End;

Function PadZeroLeft(Value:Integer;Space:Byte):String;
Var
 S:String;
Begin
 Str(Value,S);
 While Length(S)<Space do S:='0'+S;
 PadZeroLeft:=S;
End;

Function TypeToValue(S:String):Byte;Begin
 TypeToValue:=0;
 If StrToUpper(S)='TYPE 1'Then TypeToValue:=1 Else
 If StrToUpper(S)='TYPE 2'Then TypeToValue:=2 Else
 If StrToUpper(S)='TYPE 3'Then TypeToValue:=3 Else
 If StrToUpper(S)='TYPE 4'Then TypeToValue:=4 Else
 If StrToUpper(S)='TYPE 5'Then TypeToValue:=5 Else
 If StrToUpper(S)='TYPE 6'Then TypeToValue:=6 Else
 If StrToUpper(S)='TYPE 7'Then TypeToValue:=7;
End;

Procedure StringToDate(S:String;Var Year,Month,Day:Word);
Var
 Err:Word;
Begin
 Val(Copy(S,1,4),Year,Err);
 Val(Copy(S,6,2),Month,Err);
 Val(Copy(S,9,2),Day,Err);
End;

Function DateToString(X:DateTime):String;Begin
 DateToString:=IntToStr(X.Year)+'-'+
               PadZeroLeft(X.Month,2)+'-'+
               PadZeroLeft(X.Day,2);
End;

Procedure InitScr;
Var
 Driver,Mode:Integer;
 ErrCode:Integer;
Begin
 {$IFDEF FPC}
  Driver:=VGA;
  Mode:=VGAHi;
 {$ELSE}
  Driver:=Detect;
  Mode:=VGAHi;
 {$ENDIF}
 InitGraph(Driver,Mode,'');
 ErrCode:=GraphResult;
 If ErrCode=grOk Then Begin
  SetColor(White);
  SetLineStyle(0, 0, 1);
 End
  Else
 Begin
  WriteLn('Erreur graphique : ',GraphErrorMsg(ErrCode));
  Halt;
 End;
End;

BEGIN
 {$IFDEF FPC}
  {$IFDEF WINDOWS}
   SetUseACP(False);
  {$ENDIF}
 {$ENDIF}
 If(ParamStr(1)='/?')or(ParamStr(1)='--help')or(ParamStr(1)='-h')or
   (ParamStr(1)='/h')or(ParamStr(1)='/H')Then Begin
  WriteLn('BISTROL : Cette commande permet d''afficher un ',
                   ' graphique bas‚ sur les donn‚es d''un fichier ',
                   'avec l''‚chelle de Bistrol.');
  WriteLn;
  WriteLn('Syntaxe : BISTROL fichier.CSV');
  WriteLn;
  WriteLn('fichier      Ce parametre permet d''indiquer un fichier de donn‚es');
 End
  Else
 If ParamCount>0Then Begin
  FileName:=ParamStr(1);
  {$I-}Assign(SourceCSV,FileName);
  Reset(SourceCSV);{$I+}
  If IoResult<>0 Then Begin
   WriteLn('Erreur de lecture du fichier CSV !');
   Halt;
  End;
  NumRecord:=0;
  While Not EOF(SourceCSV)do Begin
   ReadLn(SourceCSV,CurrLine);
   CurrWord:='';PosField:=0;
   For I:=1 to Length(CurrLine)do Begin
    If CurrLine[I]=','Then Begin
    If(CurrWord[1]='"')and(CurrWord[Length(CurrWord)]='"')Then Begin
      If PosField=0 Then CurrDate:=Copy(CurrWord,2,Length(CurrWord)-2)
                    Else CurrType:=TypeToValue(Copy(CurrWord,2,Length(CurrWord)-2));
      Inc(PosField);
     End
      Else
     Begin
      If PosField=0 Then CurrDate:=CurrWord
                    Else CurrType:=TypeToValue(CurrWord);
      Inc(PosField);
     End;
     CurrWord:='';
    End
     Else
    CurrWord:=CurrWord+CurrLine[I];
   End;
   If CurrWord<>''Then Begin
    If PosField=0 Then CurrDate:=CurrWord
                  Else CurrType:=TypeToValue(CurrWord);
   End;
   TypeArray[NumRecord]:=CurrType;
   StringToDate(CurrDate,DateArray[NumRecord].Year,
                         DateArray[NumRecord].Month,
                         DateArray[NumRecord].Day);
   Inc(NumRecord);
   If NumRecord>High(DateArray)Then Break;
  End;
  Close(SourceCSV);
  If NumRecord>0Then Begin
   InitScr;
   OutTextXY(320-(TextWidth('chelle de Bistrol')shr 1),0,'chelle de Bistrol');
   OutTextXY(0,30,'chantillion de donn‚es du fichier ®'+FileName+'¯');
   WidthBar:=575 div NumRecord;
   X:=0;NextX:=0;
   For I:=0 to NumRecord-1 do Begin
    Case I and 1 of
     0:SetFillStyle(SolidFill,LightGray);
     1:SetFillStyle(SolidFill,White);
    End;
    Bar(X,(HeightScreen-1)-TypeArray[I]*55,X+WidthBar-1,HeightScreen-1-20);
    If X>=NextX Then Begin
     OutTextXY(X,(HeightScreen-1)-10,DateToString(DateArray[I]));
     NextX:=NextX+TextHeight(DateToString(DateArray[I])+' ');
    End;
    Inc(X,WidthBar);
   End;
   For I:=0 to 6 do OutTextXY(580,(HeightScreen-1)-20-(I*55)-TextHeight('Type'),'Type '+IntToStr(I+1));
   ReadKey;
  End
   Else
  WriteLn('Aucune donn‚es n''est pr‚sente pour analyse');
 End;
END.