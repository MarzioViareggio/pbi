= (#"data iniziale" as date)=>
let
    #"elenco date"=List.Dates(#"data iniziale",
    Number.From(Date.From(DateTime.LocalNow())- #"data iniziale")+1,
    #duration(1,0,0,0)),
    #"tabella date"= Table.FromList(#"elenco date",Splitter.SplitByNothing(), {"Date"}),
    #"anno"=Table.AddColumn(#"tabella date","Anno",each Date.Year([Date])),
    #"numero mese" = Table.AddColumn(#"anno","Numero del mese", each Date.Month([Date])),
    #"nome mese"=Table.AddColumn(#"numero mese","Nome del mese", each Date.MonthName([Date])),
    #"trimestre"=Table.AddColumn(#"nome mese","Trimestre",each Date.QuarterOfYear([Date])),
    #"settimana dell'anno"=Table.AddColumn(#"trimestre","Settimana dell'anno", each Date.WeekOfYear([Date])),
    #"tipi di dati corretti"=Table.TransformColumnTypes(#"settimana dell'anno",
    {{"Date", type date}, {"Anno", Int64.Type},{"Numero del mese",Int64.Type}, 
    {"Nome del mese", type text}, {"Trimestre", Int64.Type}, {"Settimana dell'anno", Int64.Type}})
in
    #"tipi di dati corretti"