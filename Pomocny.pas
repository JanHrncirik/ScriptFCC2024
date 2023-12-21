//Pôvodné vyhľadávania fixu otborenia odletu
if NbrFixes > 0 then
        begin
          while  (j < NbrFixes) and (Pilots[i].Fixes[j].TSec < Task.NoStartBeforeTime) do 
          begin
            j := J + 1;
          end;
//
//binárne vyhľadávanie fixu času otvorenia odletu 
  center, Vleft, Vright, Vresult, item: Integer;
// binary searches Begin
        if Task.NoStartBeforeTime <= 0 then // Nie je nastavený čas otvorenia odletu!
          begin
            Info1 := 'Nie je nastavený čas otvorenia odletu! Nastavte čas otvorenia odletu!!!' ;
            exit;
          end;
        begin
          item := Task.NoStartBeforeTime;
          Vleft:=0;
          Vright:= GetArrayLength(Pilots[i].Fixes) - 1;
          if Vright < 0 then
            begin
               Info1 := 'Vright = -1, IGC súbor je prázdny. Má 0 fixov.';
               Exit;
            end;
          if ((item < Pilots[i].Fixes[Vleft].Tsec) or (item > Pilots[i].Fixes[Vright].Tsec)) then // element out of scope, Čas otvorenia odletu je mimo rozsah fixov IGC súboru.
          begin
            Vresult:=-1; //príznak pre ladenie, -1 pilotov odlet je mimo fixov, 1 fix nájdený, 2 fix nájdený – interval fixov väčší ako 1 s
            Info1 := 'element out of scope, Čas otvorenia odletu je mimo rozsah fixov IGC súboru. item = ' + GetTimeString(item);
            exit;
          end;

          while (Vleft <= Vright) and (Vright > 20) do begin // if we have something to share, Ak máme čo deliť
            center:=(Vleft + Vright) div 2;
            if (item = Pilots[i].Fixes[center].Tsec) then
              begin
                j := center;
                Vresult:= 1; // found, nájdené, príznak pre ladenie
                Break; // Ending the loop while, Ukonči slučku while!
            end
            else
            if (item < Pilots[i].Fixes[center].Tsec) then
              Vright:=center - 1 // throw away the Vright half, zahodiť pravú (Vright) polovicu
            else
              Vleft:=center + 1; // discard the Vleft half, zahodiť ľavú (Vleft) polovicu
              if (item < Pilots[i].Fixes[Vleft].Tsec) then //nebol 1 sekundový záznam, priradí najbližší vyšší fix po čase otvorenia odletu
                begin
                  j := center + 1;
                  Vresult:= 2; // found, nájdené, príznak pre ladenie
                  Break; // Ending the loop while, Ukonči slučku while!
                end;

            end;
        end;
        // binary searches End