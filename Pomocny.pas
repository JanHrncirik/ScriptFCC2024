// binary searches Begin
        begin
          item := Trunc(Pilots[i].start);
          Vleft:=0;
          Vright:= GetArrayLength(Pilots[i].Fixes) - 1;
          if Vright < 0 then
            begin
               Info1 := 'Vright = -1';
               Exit;
            end;
          if ((item < Pilots[i].Fixes[Vleft].Tsec) or (item > Pilots[i].Fixes[Vright].Tsec)) then // element out of scope
          begin
            Vresult:=-1;
            Info1 := 'element out of scope item = ' + IntToStr(item);
            exit;
          end;

          while (Vleft <= Vright) and (Vright > 20) do begin // if we have something to share
            center:=(Vleft + Vright) div 2;
            if (item = Pilots[i].Fixes[center].Tsec) then
              begin
                PilotStartAlt := Pilots[i].Fixes[center].AltQnh;
                PilotStartSpeed := Pilots[i].Fixes[center].Gsp;
                Vresult:= 1; // found
                Break; // Ending the loop while
            end
            else
            if (item < Pilots[i].Fixes[center].Tsec) then
              Vright:=center - 1 // throw away the Vright half
            else
              Vleft:=center + 1; // discard the Vleft half
              if (item < Pilots[i].Fixes[Vleft].Tsec) then
                begin
                  PilotStartAlt := (Pilots[i].Fixes[center].AltQnh + Pilots[i].Fixes[center+1].AltQnh) / 2;
                  PilotStartSpeed := (Pilots[i].Fixes[center].Gsp + Pilots[i].Fixes[center+1].Gsp) / 2;
                  Vresult:= 2; // found
                  Break; // Ending the loop while
                end;

            end;
        end;
        // binary searches End