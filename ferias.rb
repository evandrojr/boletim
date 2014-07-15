#!/usr/bin/env ruby

def buildLeave(month, data)

 return "" if data.empty?
  
 content = "<div align='center'>
  <strong>FÉRIAS DO MÊS DE #{month.upcase}</strong>
  <br><br>"
   content += '
  <table style="color: #000000; font-size: 90%; width: 100%;" border="0" align="center">
  <tbody>
  <tr>
  <td width="55%">
  <div>Nome</div>
  </td>
  <td width="15%">
  <div>Início</div>
  </td>
  <td width="15%">
  <div>Término</div>
  </td>
  <td width="15%">Duração</td>
  </tr>'
  
  data.each{|d|
    content+="  
      <tr>
      <td width='55%'>
      <div>#{d[0]}</div>
      </td>
      <td width='15%'>
      <div>#{d[1]}</div>
      </td>
      <td width='15%'>
      <div>#{d[2]}</div>
      </td>
      <td width='15%'>
      <div>#{d[3]}</div>
      </td>
      </tr>
    "
  }
  content+="</tbody>
  </table>
  </div>"  
end

