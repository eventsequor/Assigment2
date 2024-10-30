functor
import
    System(showInfo:Show)

export
    MainTask

define
    % ===============================================
    % ================ Functions ====================
    % ===============================================
    fun {Sum_row Matrix RowNumber}        
        {FoldL {Nth Matrix RowNumber} fun {$ X Y} X+Y end 0}
    end

    fun {Sum_colum Matrix RowNumber}        
        {FoldL {Map Matrix fun{$ Row} {Nth Row RowNumber} end} fun {$ X Y} X+Y end 0}
    end

    fun {Sum_all Matrix}
        {FoldL Matrix fun {$ Acu Row} {FoldL Row fun {$ A B} A+B end 0} + Acu end 0}
    end

    fun {Mult_all Matrix}
        {FoldL Matrix fun {$ Acu Row} {FoldL Row fun {$ A B} A*B end 1} * Acu end 1}
    end

    % ===============================================
    % ================ Utilities ====================
    % ===============================================

    fun {PrintList L}
        local R={NewCell "|"} in
            for P in L do
                if @R == "|" then R := @R # P else R := @R # " " # P end
                 
            end
            R := @R # "|"
            @R
        end
    end

    fun {PrintMatrix M}
        local String = {NewCell ""} in
            for R in M do
                String := @String#"\n"#{PrintList R}
            end
            @String
        end
    end
    % ===============================================
    % ================== Test =======================
    % ===============================================
    proc {Test1}
        {Show "\n========== Test 1 =========="}
        {Show "Sum the elements into the row from the matrix"}
        local MatrixE in
            MatrixE = [[7 2 6] [3 4 2] [9 5 1]]
            {Show "The matrix is: "}
            {Show {PrintMatrix MatrixE}}
            {Show "Sum the value in the row number 3 = [9 5 1], the expected result is: 15"}
            {Show {Sum_row MatrixE 3}}
        end
    end

    proc {Test2}
        {Show "\n========== Test 2 =========="}
        {Show "Sum the elements into the colum from the matrix"}
        local MatrixE in
            MatrixE = [[7 2 6] [3 4 2] [9 5 1]]
            {Show "The matrix is: "}
            {Show {PrintMatrix MatrixE}}
            {Show "Sum the value in the colum number 2 = [2 4 5], the expected result is: 11"}
            {Show "Result: "#{Sum_colum MatrixE 2}}
        end
    end

    proc {Test3}
        {Show "\n========== Test 3 =========="}
        {Show "Sum all elements into the matrix"}
        local MatrixE Result Obj in
            MatrixE = [[7 2 6 5] [2 7 2 1] [9 5 1 3] [4 4 1 8]]
            {Show "The matrix is: "}
            {Show {PrintMatrix MatrixE}}
            {Show "Sum all values the expected result is: 67"}
            {Show "Result: "#{Sum_all MatrixE}}
        end
    end

    proc {Test4}
        {Show "\n========== Test 4 =========="}
        {Show "Sum mult all elements into the matrix"}
        local MatrixE in
            MatrixE = [[6 5] [2 1] [1 3] [1 8]]
            {Show "The matrix is: "}
            {Show {PrintMatrix MatrixE}}
            {Show "Multiplication of all values is -> expected result is: 1440"}
            {Show "Result: "#{Mult_all MatrixE}}
        end
    end

    proc {MainTask}
        {Show "\n============================"}
        {Show "========== Task 2 =========="}
        {Show "============================\n"}
        {Test1}
        {Test2}
        {Test3}
        {Test4}
    end
    {MainTask}
end