select
  case 
   when timestampdiff(year,p.birth_date,e.admission_date) < 65 then '６５歳未満'
   when timestampdiff(year,p.birth_date,e.admission_date) between 65 and 74 then '６５歳～７４歳'
   else '７５歳以上'
  end as 年齢層,
  p.gender as 性別,
  count(e.encounter_id) as 入院件数,
  round(avg(dr.total_claim_cost),0) as 平均医療費
 from encounters e
 join patients p on e.patient_id = p.patient_id
 join diagnoses d on d.encounter_id = e.encounter_id
 join dpc_records dr on dr.encounter_id = e.encounter_id
 group by 年齢層,性別
 order by 年齢層,性別