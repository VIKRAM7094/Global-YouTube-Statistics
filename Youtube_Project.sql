#1. Top youtube players
#2a. Top continent in the YT space; uploads, Views, Earnings and subscribers
#2b. Percentage of pay continent
#3. Top 8 countries, percentage pay
#4. Top 8 channel types, sum views
/*
 SELECT
     Country,
    case
      when Country in ("Algeria","Angola","Benin","Botswana","Burkina Faso","Burundi","Cabo Verde","Cameroon","Central African Republic",
           "Chad","Comoros","Congo, Dem. Rep", "Congo, Rep.","Cote d'Ivoire","Djibouti","Egypt","Equatorial Guinea","Eritrea",
           "Eswatini (formerly Swaziland)","Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea-Bissau","Kenya", "Lesotho",
           "Liberia",'Libya',"Madagascar","Malawi","Mali","Mauritania","Mauritius","Morocco","Mozambique","Namibia",
           "Niger","Nigeria","Rwanda","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia","South Africa",
           "South Sudan","Sudan","Tanzania""Togo","Tunisia","Uganda","Zambia","Zimbabwe") then 'Africa'

      when Country in ("Albania","Andorra", "Armenia","Austria","Azerbaijan","Belarus","Belgium","Bosnia and Herzegovina",
           "Bulgaria","Croatia","Cyprus","Czechia","Denmark","Estonia","Finland","France","Georgia","Germany",
           "Greece","Hungary","Iceland","Ireland","Italy","Kazakhstan","Kosovo","Latvia","Liechtenstein","Lithuania",
           "Luxembourg","Malta","Moldova","Monaco","Montenegro","Netherlands","Macedonia, FYR","Norway","Poland","Portugal",
           "Romania","Russia","San Marino","Serbia","Slovakia","Slovenia","Spain","Sweden","Switzerland","Turkey",
           "Ukraine","United Kingdom","Vatican City") then 'Europe'

      when Country in ("Afghanistan","Armenia","Azerbaijan","Bahrain","Bangladesh", "Bhutan","Brunei","Cambodia","China","Cyprus",
         "Georgia","India","Indonesia","Iran","Iraq","Israel","Japan","Jordan","Kazakhstan","Kuwait","Kyrgyzstan","Laos",
         "Lebanon","Malaysia","Maldives","Mongolia","Myanmar","Nepal","North Korea","Oman","Pakistan","Palestine","Philippines",
         "Qatar","Russia","Saudi Arabia","Singapore","South Korea","Sri Lanka","Syria","Taiwan","Tajikistan","Thailand",
	      "Timor-Leste","Turkey","Turkmenistan","United Arab Emirates","Uzbekistan","Vietnam","Yemen") then 'Asia'

     when Country in ("Antigua and Barbuda","Bahamas","Barbados","Belize","Canada","Costa Rica","Cuba","Dominica",
         "Dominican Republic","El Salvador","Grenada","Guatemala","Haiti","Honduras","Jamaica","Mexico",
         "Nicaragua","Panama","Saint Vincent and the Grenadines","United States") then 'North_America'

     when Country in ("Argentina","Bolivia","Brazil","Chile","Colombia","Ecuador","Guyana","Paraguay","Peru","Suriname",
         "Uruguay","Venezuela") then 'South_America'

    when Country in ("Australia","Fiji","Kiribati","Marshall Islands","Micronesia","Nauru","New Zealand","Palau",
        "Papua New Guinea","Samoa","Solomon Islands","Tonga","Tuvalu","Vanuatu") then 'Australia_and_Oceania '
	 end as continents,
    
    
	sum(subscribers) as total_subs, 
    sum(uploads) as total_uploads,
    sum(`video views`) as video_views, 
    round(sum(highest_yearly_earnings),0) as total_earnings,
   count(Youtuber) as num_of_youtubers
   FROM yt_stats.`global youtube statistics`
 Group by continents
 order by 5 desc
 ;
*/
-- 2b. Percentage of pay continent
/*
With pct_pay as(
SELECT
    -- Country,
    case
     when Country in ("Algeria","Angola","Benin","Botswana","Burkina Faso","Burundi","Cabo Verde","Cameroon","Central African Republic",
          "Chad","Comoros","Congo, Dem. Rep", "Congo, Rep.","Cote d'Ivoire","Djibouti","Egypt","Equatorial Guinea","Eritrea",
          "Eswatini (formerly Swaziland)","Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea-Bissau","Kenya", "Lesotho",
          "Liberia",'Libya',"Madagascar","Malawi","Mali","Mauritania","Mauritius","Morocco","Mozambique","Namibia",
          "Niger","Nigeria","Rwanda","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia","South Africa",
          "South Sudan","Sudan","Tanzania""Togo","Tunisia","Uganda","Zambia","Zimbabwe") then 'Africa'

     when Country in ("Albania","Andorra", "Armenia","Austria","Azerbaijan","Belarus","Belgium","Bosnia and Herzegovina",
          "Bulgaria","Croatia","Cyprus","Czechia","Denmark","Estonia","Finland","France","Georgia","Germany",
          "Greece","Hungary","Iceland","Ireland","Italy","Kazakhstan","Kosovo","Latvia","Liechtenstein","Lithuania",
          "Luxembourg","Malta","Moldova","Monaco","Montenegro","Netherlands","Macedonia, FYR","Norway","Poland","Portugal",
          "Romania","Russia","San Marino","Serbia","Slovakia","Slovenia","Spain","Sweden","Switzerland","Turkey",
         "Ukraine","United Kingdom","Vatican City") then 'Europe'

     when Country in ("Afghanistan","Armenia","Azerbaijan","Bahrain","Bangladesh", "Bhutan","Brunei","Cambodia","China","Cyprus",
        "Georgia","India","Indonesia","Iran","Iraq","Israel","Japan","Jordan","Kazakhstan","Kuwait","Kyrgyzstan","Laos",
        "Lebanon","Malaysia","Maldives","Mongolia","Myanmar","Nepal","North Korea","Oman","Pakistan","Palestine","Philippines",
        "Qatar","Russia","Saudi Arabia","Singapore","South Korea","Sri Lanka","Syria","Taiwan","Tajikistan","Thailand",
        "Timor-Leste","Turkey","Turkmenistan","United Arab Emirates","Uzbekistan","Vietnam","Yemen") then 'Asia'

     when Country in ("Antigua and Barbuda","Bahamas","Barbados","Belize","Canada","Costa Rica","Cuba","Dominica",
         "Dominican Republic","El Salvador","Grenada","Guatemala","Haiti","Honduras","Jamaica","Mexico",
        "Nicaragua","Panama","Saint Vincent and the Grenadines","United States") then 'North_America'

     when Country in ("Argentina","Bolivia","Brazil","Chile","Colombia","Ecuador","Guyana","Paraguay","Peru","Suriname",
         "Uruguay","Venezuela") then 'South_America'

     when Country in ("Australia","Fiji","Kiribati","Marshall Islands","Micronesia","Nauru","New Zealand","Palau",
         "Papua New Guinea","Samoa","Solomon Islands","Tonga","Tuvalu","Vanuatu") then 'Australia_and_Oceania '
	end as continents,
    
    
    round(sum(highest_yearly_earnings),0) as total_earnings
FROM yt_stats.`global youtube statistics`
Group by 1
order by 2 desc
)
Select 

sum(total_earnings) as total_earnings,

 round(1.0 * sum(case when continents = 'Africa' then total_earnings else 0 end)/ nullif(sum(total_earnings),0)*100,2) as pct_earnings_africa,
 round(1.0 * sum(case when continents = 'Asia' then total_earnings else 0 end)/ nullif(sum(total_earnings),0)*100,2) as pct_earnings_Asia,
 round(1.0 * sum(case when continents = 'North_America' then total_earnings else 0 end)/ nullif(sum(total_earnings),0)*100,2) as pct_earnings_North_America,
 round(1.0 * sum(case when continents = 'Europe' then total_earnings else 0 end)/ nullif(sum(total_earnings),0)*100,2) as pct_earnings_Europe,
 round(1.0 * sum(case when continents = 'South_America' then total_earnings else 0 end)/ nullif(sum(total_earnings),0)*100,2) as pct_earnings_South_America,
 round(1.0 * sum(case when continents = 'Australia_and_Oceania' then total_earnings else 0 end)/ nullif(sum(total_earnings),0)*100,2) as pct_earnings_Australia_and_Oceania
 
 #Asia, North_America, Europe, South_America, Australia_and_ Oceania

from pct_pay
;
*/

#3. Top 8 countries, percentage pay
/*
with country_pct as (
Select
Country,
round(sum(highest_yearly_earnings),0) as total_earnings
FROM yt_stats.`global youtube statistics`
Group by 1
Order by 2 desc
)

select 
sum(total_earnings) as total_earnings,

round(1.0*sum(case when country = 'United States' then total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) as Pct_US,
round(1.0*sum(case when country = 'India' then total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) as Pct_India,
round(1.0*sum(case when country = 'Brazil' then total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) as Pct_Brazil,
round(1.0*sum(case when country = 'South Korea' then total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) as Pct_South_Korea,
round(1.0*sum(case when country = 'United Kingdom' then total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) as Pct_United_Kingdom,
round(1.0*sum(case when country = 'Pakistan' then total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) as Pct_Pakistan,
round(1.0*sum(case when country = 'Argentina' then total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) as Pct_Argentina,
round(1.0*sum(case when country = 'Russia' then total_earnings else 0 end)/nullif(sum(total_earnings),0)*100,2) as Pct_Russia

from country_pct
;
*/
#4. Top 8 channel types, sum views
select
channel_type,
sum(`video views`) as total_views
From yt_stats.`global youtube statistics`
Group by 1
order by 2 desc
Limit 8
;