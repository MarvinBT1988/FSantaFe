using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SqlClient;

namespace FSantaFe.Facturacion.AccesoADatos
{
 public class ComunDB
 {
  const string StrConexion = @"Data Source=198.38.83.200;Initial Catalog=eliqsv_facturacion;Persist Security Info=True;User ID=eliqsv_estudiante2021;Password=xd9ofzqcvbwrtselgmhy";
  private static SqlConnection ObtenerConexion() 
  {
   SqlConnection connection = new SqlConnection(StrConexion);
   connection.Open();
   return connection;
  }
  public static SqlCommand ObtenerComando() 
  {
   SqlCommand command = new SqlCommand();
   command.Connection = ObtenerConexion();
   return command;
  }
  public static int EjecutarComando(SqlCommand pComando) 
  {
   int resultado = pComando.ExecuteNonQuery();
   pComando.Connection.Close();
   return resultado;
  }
  public static SqlDataReader EjecutarComandoReader(SqlCommand pComando)
  {
   SqlDataReader reader = pComando.ExecuteReader(CommandBehavior.CloseConnection);
   return reader;
  }
 }
}
