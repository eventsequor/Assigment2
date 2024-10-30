functor
import
    System(showInfo:Show)
    Utils(printList:PrintList)

export
    MainTask

define
    % ===============================================
    % ================ Functions ====================
    % ===============================================
    
    fun {DeclareInterval LowerLimit1 UpperLimit1}
        local 
            UpperLimit = {NewCell 0}
            LowerLimit = {NewCell 0}
        in
            if(UpperLimit1 >= LowerLimit1) then
                UpperLimit := UpperLimit1
                LowerLimit := LowerLimit1
            else 
                UpperLimit := LowerLimit1
                LowerLimit := UpperLimit1
            end
            UpperLimit := {IntToFloat @UpperLimit}
            LowerLimit := {IntToFloat @LowerLimit}
            [@LowerLimit @UpperLimit]
        end
    end

    GetLeftPoint = fun {$ Interval} if {Length Interval}==2 then {Nth Interval 1} else nil end end
    GetRightPoint = fun {$ Interval} if {Length Interval}==2 then {Nth Interval 2} else nil end end
    IsThePointInTheInterval = fun {$ Interval Point} if {IntToFloat Point} > {GetLeftPoint Interval} andthen {IntToFloat Point} < {GetRightPoint Interval} then true else false end end       
    Update = fun {$ OriginalInterval NewLeftPoint NewRightPoint} {DeclareInterval NewLeftPoint NewRightPoint} end
    
    fun {IsInTheInterval IntervalRoot IntervalToEvaluate}
        local IsLeftPointIn IsRightPoint Result in
            IsLeftPointIn = {IsThePointInTheInterval IntervalRoot {GetLeftPoint IntervalToEvaluate}}
            IsRightPoint = {IsThePointInTheInterval IntervalRoot {GetRightPoint IntervalToEvaluate}}
            if IsLeftPointIn andthen IsRightPoint then Result = is_contained end
            if IsLeftPointIn andthen IsRightPoint == false then Result = left_contained end
            if IsLeftPointIn == false andthen IsRightPoint then Result = right_contained end
            if IsLeftPointIn == false andthen IsRightPoint == false then Result = not_contained end
            Result
        end
    end

    fun {IntToFloat Number}
        local 
            IsNumber
            {Int.is Number ?IsNumber}
            OutPut
        in
            if IsNumber then 
                {Int.toFloat Number ?OutPut}  
                OutPut 
            else 
                Number 
            end
        end
    end

    % ===============================================
    % ================== Test =======================
    % ===============================================
    proc {Test1}
        {Show "\n========== Test 1 =========="}
        {Show "Returns the left endpoint of the interval"}
        local 
            Obj
            LeftPoint = 2.0
            RightPoint = 8.0
            Output
        in
            {Show "The interval is: ("#LeftPoint#" - "#RightPoint#")"}
            {Show "The left endpoint is: "#{GetLeftPoint {DeclareInterval LeftPoint RightPoint}}}
        end
    end

    proc {Test2}
        {Show "\n========== Test 2 =========="}
        {Show "Returns the right endpoint of the interval"}
        local 
            Obj
            LeftPoint = 3.0
            RightPoint = 7.0
            Output
        in
            {Show "The interval is: ("#LeftPoint#" - "#RightPoint#")"}
            {Show "The right endpoint is: "#{GetRightPoint {DeclareInterval LeftPoint RightPoint}}}
        end
    end

    proc {Test3}
        {Show "\n========== Test 3 =========="}
        {Show "That receives a floating number and determines if the point is in the interval"}
        local 
            Obj
            LefEndPoint = 1.0
            RightPoint = 9.0

            Inside = 4.9
            InsideReturn

            Outside = 10
            OutsideReturn
            
            OutsideLeft = LefEndPoint
            OutsideLeftReturn

            OutsideRight = RightPoint
            OutsideRightReturn
        in
            {Show "Interval ("#LefEndPoint#" - "#RightPoint#")\n"}
            InsideReturn = {IsThePointInTheInterval {DeclareInterval LefEndPoint RightPoint} Inside}
            if InsideReturn then
                {Show "The point <"#Inside#"> IS in the interval: "}
            else
                {Show "The point <"#Inside#"> IS NOT in the interval"}
            end

            OutsideReturn = {IsThePointInTheInterval {DeclareInterval LefEndPoint RightPoint} Outside}
            if OutsideReturn then
                {Show "The point <"#Outside#"> IS in the interval"}
            else
                {Show "The point <"#Outside#"> IS NOT in the interval"}
            end

            OutsideLeftReturn = {IsThePointInTheInterval {DeclareInterval LefEndPoint RightPoint} OutsideLeft}
            if OutsideLeftReturn then
                {Show "The point <"#OutsideLeft#"> IS in the interval"}
            else
                {Show "The point <"#OutsideLeft#"> IS NOT in the interval"}
            end

            OutsideRightReturn = {IsThePointInTheInterval {DeclareInterval LefEndPoint RightPoint} OutsideRight}
            if OutsideRightReturn then
                {Show "The point <"#OutsideRight#"> IS in the interval"}
            else
                {Show "The point <"#OutsideRight#"> IS NOT in the interval"}
            end
        end
    end

    proc {Test4}
        local 
            Obj
            LefEndPoint = 5.0
            RightPoint = 15.0

            IntervaOneLeft = 5.1
            IntervalOneRight = 14.9
            ResultOne

            IntervalTwoLeft = 7.0
            IntervalTwoRight = 16.0
            ResutlTwo

            IntervalThreeLeft = 2.0
            IntervalThreeRight = 13.0
            ResultThree

            IntervalFourLeft = 3.0
            IntervalFourRight = 20.0
            ResultFour
        in
            {Show "\n========== Test 4 =========="}
            {Show "that receive an interval an determines whether the interval is contained, left-contained"}
            {Show "(only the left endpoint of the parameter is in the interval), right-contained (only the"}
            {Show "right endpoint of the parameter is in the interval), disjoint, or contains the interval\n"}
            {Show "Original interval ("#LefEndPoint#" - "#RightPoint#")"}
            
            ResultOne = {IsInTheInterval {DeclareInterval LefEndPoint RightPoint} {DeclareInterval IntervaOneLeft IntervalOneRight}}
            {Show "\nInterval ("#IntervaOneLeft#" - "#IntervalOneRight#") is: "#ResultOne}
            
            ResutlTwo = {IsInTheInterval {DeclareInterval LefEndPoint RightPoint} {DeclareInterval IntervalTwoLeft IntervalTwoRight}}
            {Show "\nInterval ("#IntervalTwoLeft#" - "#IntervalTwoRight#") is: "#ResutlTwo}

            ResultThree = {IsInTheInterval {DeclareInterval LefEndPoint RightPoint} {DeclareInterval IntervalThreeLeft IntervalThreeRight}}
            {Show "\nInterval ("#IntervalThreeLeft#" - "#IntervalThreeRight#") is: "#ResultThree}

            ResultFour = {IsInTheInterval {DeclareInterval LefEndPoint RightPoint} {DeclareInterval IntervalFourLeft IntervalFourRight}}
            {Show "\nInterval ("#IntervalFourLeft#" - "#IntervalFourRight#") is: "#ResultFour}
        end
    end

    proc {Test5}
        local
            Obj
            LefEndPoint = 10.0
            RightPoint = 20.0

            NewLeftPoint = 30.0
            NewRightPoint = 50.0

            OutsideLeft
            OutsideRight
        in
            {Show "\n========== Test 4 =========="}
            {Show "That receives two floating numbers and updates the left and right endpoints of the"}
            {Show "interval"}
            {Show "\nOriginal interval ("#LefEndPoint#" - "#RightPoint#")\n"}
            
            OutsideLeft = {GetLeftPoint {Update {DeclareInterval LefEndPoint RightPoint} NewLeftPoint NewRightPoint}}
            OutsideRight = {GetRightPoint {Update {DeclareInterval LefEndPoint RightPoint} NewLeftPoint NewRightPoint}}

            {Show "The new interval is: ("#OutsideLeft#" - "#OutsideRight#")"}
        end
    end

    proc {MainTask}
        local Obj R Point IsIn in
            {Show "\n============================"}
            {Show "========== Task 1 =========="}
            {Show "============================\n"}
            {Test1}
            {Test2}
            {Test3}
            {Test4}
            {Test5}
        end
    end
    {MainTask}
end