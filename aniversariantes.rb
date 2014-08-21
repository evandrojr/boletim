#!/usr/bin/env ruby
# encoding: utf-8

def buildBirthdayGuys(month, data)

  return "" if data.empty?
  
  content = "<div align='center'><strong>ANIVERSARIANTES DO MÊS DE #{month.upcase}</strong>
  <br><br>"
  content += '
  <table style="width: 100%; font-size: 90%;" align="center">
  <tbody>
  <tr>
  <td width="10%">
  <div align="LEFT">Dia</div>
  </td>
  <td width="60%">
  <div align="LEFT">Nome</div>
  </td>
  <td width="30%">
  <div align="LEFT">Setor</div>
  </td>
  </tr>'
  
data.each{|d|
  content+="  
  <tr>
  <td>
  <div align='LEFT'>#{d[0]}</div>
  </td>
  <td>
  <div align='LEFT'>#{d[1]}</div>
  </td>
  <td>
  <div align='LEFT'>#{d[2]}</div>
  </td>
  </tr>"
}

content+="</tbody>
</table>
</div>"  
  
end

