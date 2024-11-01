functor
import
      System(showInfo:Show) 
export
    MainTask

define    
    % Return a list of records
    fun {FemaleEmployees Records}
        local FilterFamele in
            FilterFamele = fun {$ Record} local G in {Value.'.' Record gender G} G=="female" end end
            {Filter Records FilterFamele}
        end
    end

    fun {MaleEmployees Records}
        local FilterMale in
            FilterMale = fun {$ Record} local G in {Value.'.' Record gender G} G=="male" end end
            {Filter Records FilterMale}
        end
    end

    fun {ClericalEmployees Records}
        local ClericalFilter in
            ClericalFilter = fun {$ Record} local R in {Value.'.' Record role R} R==clerical end end
            {Filter Records ClericalFilter}
        end
    end

    fun {Managers Records}
        local ManagersFilter in
            ManagersFilter = fun {$ Record} local R in {Value.'.' Record role R} R==managerial end end
            {Map {Filter Records ManagersFilter} fun {$ Record} local Name in {Value.'.' Record name Name} Name end end}
        end
    end

    fun {MeanAge Records}
        local AgeList in
            AgeList = {Map {FemaleEmployees {ClericalEmployees Records}} fun {$ Record} local Age in {Value.'.' Record age Age} Age end end}
            {IntToFloat {FoldL AgeList fun {$ X Y} X+Y end 0}} / {IntToFloat {Length AgeList}}
        end
    end

    fun {MaleEmployees60 Records}
        {FilterRecordByAge {MaleEmployees Records} 60}
    end

    fun {FilterRecordByAge Records MayorThan}
        local AgeFilter in
            AgeFilter = fun {$ Record} local A in {Value.'.' Record age A} A>MayorThan end end
            {Filter Records AgeFilter}
        end
    end

    fun {GetRecordString Record}
        local String ={NewCell {Label Record}#"( "} in
            for L in {Arity Record} do Va in
                {Value.'.' Record L Va}
                String := @String#L#":"#Va#" "
            end
            @String#")"
        end
    end

    proc {Test1 EmployeeList}
        {Show "\n========== Test 1 =========="}
        {Show "FemaleEmployees, that returns all female employees in the company\n"}
        {Show "Famele employees\n"}
        for Record in {FemaleEmployees EmployeeList} do
            {Show {GetRecordString Record}}                
        end
    end

    proc {Test2 EmployeeList}
        {Show "\n========== Test 2 =========="}
        {Show "MaleEmployees60, that return all male employees over 60\n"}
        {Show "Male employees over 60\n"}
        for Record in {MaleEmployees60 EmployeeList}do
            {Show {GetRecordString Record}}                
        end
    end

    proc {Test3 EmployeeList}
        {Show "\n========== Test 3 =========="}
        {Show "Managers, that returns a list with the names of all managers\n"}
        {Show "Name of manages\n"}
        for Name in {Managers EmployeeList}do
            {Show Name}                
        end
    end

    proc {Test4 EmployeeList}
        {Show "\n========== Test 4 =========="}
        {Show "MeanAge, that returns the mean age of all female clerical employees\n"}
        {Show "Mean age\n"}
        {Show {MeanAge EmployeeList}} 
    end

    proc {MainTask}        
        local 
            EmployeeList = [
                a(name:"Eder" age:30 gender:"male" role:managerial)
                b(name:"Johana" age:29 gender:"female" role:manual)
                c(name:"Pedro" age:71 gender:"male" role:manual)
                d(name:"Alejandro" age:67 gender:"male" role:managerial)
                f(name:"Elizabeth" age:19 gender:"female" role:clerical)
                g(name:"Lina" age:41 gender:"male" role:managerial)
                h(name:"Brian Chesky" age:43 gender:"male" role:managerial)
                i(name:"Lyzath" age:36 gender:"other" role:clerical)
                j(name:"Amanda" age:51 gender:"female" role:clerical)
            ]
        in
            {Show "\n============================"}
            {Show "========== Task 4 =========="}
            {Show "============================\n"}
            {Show "Original list of records\n"}
            for E in EmployeeList do
                {Show {GetRecordString E}}
            end
            {Show "\n"}

            {Test1 EmployeeList}
            {Test2 EmployeeList}
            {Test3 EmployeeList}
            {Test4 EmployeeList}
        end
    end 
    {MainTask}
end