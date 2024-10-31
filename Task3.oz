functor
import
      System(showInfo:Show print:Print) 
      Application(exit:Exit)
export
    MainTask

define    

    fun {QuickSort L}
        case L of X|L2 then Left Right LAppend in
            LAppend = fun {$ Xs Ys} case Xs of X|Xr then X|{LAppend Xr Ys} [] nil then Ys end end
            {LAppend {QuickSort {Filter L2 fun {$ A} A =< X end}} X|{QuickSort {Filter L2 fun {$ A} A > X  end}}}
        [] nil then nil
        end
    end

    fun {PrintList L}
        local R={NewCell "|"} in
            for P in L do if @R == "|" then R := @R # P else R := @R # " " # P end end
            R := @R # "|"
            @R
        end
    end

    proc {MainTask}        
        local 
            ListEder = [167 3 1 4 1 5 9 2 6 5 10 120 ~1 ~7 14 99 88 ~238]
        in
            {Show "\n============================"}
            {Show "========== Task 3 =========="}
            {Show "============================\n"}
            {Show "Original list: "#{PrintList ListEder}} 
            {Show "Size original list: "#{Length ListEder}}
            {Show "New list sorted: "#{PrintList {QuickSort ListEder}}}
            {Show "Size target list: "#{Length {QuickSort ListEder}}}
        end
    end 
    {MainTask}
end