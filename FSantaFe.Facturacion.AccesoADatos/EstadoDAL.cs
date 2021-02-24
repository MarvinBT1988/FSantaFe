using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using FSantaFe.Facturacion.EntidadesDeNegocio;

namespace FSantaFe.Facturacion.AccesoADatos
{
    public class EstadoDAL
    {
        public static int Guardar(Estado pEstado)
        {
            string consulta = "INSERT INTO Estado(Nombre) VALUES(@Nombre)";
            SqlCommand comando = ComunDB.ObtenerComando();
            comando.CommandText = consulta;
            comando.Parameters.AddWithValue("@Nombre", pEstado.Nombre);
            return ComunDB.EjecutarComando(comando);
        }
        public static int Modificar(Estado pEstado)
        {
            string consulta = "UPDATE Estado SET Nombre=@Nombre WHERE Id=@Id";
            SqlCommand commando = ComunDB.ObtenerComando();
            commando.CommandText = consulta;
            commando.Parameters.AddWithValue("@Nombre", pEstado.Nombre);
            commando.Parameters.AddWithValue("@Id", pEstado.Id);
            return ComunDB.EjecutarComando(commando);
        }
        public static int Eliminar(Estado pEstado)
        {
            string consulta = "DELETE FROM Estado WHERE Id=@Id";
            SqlCommand comando = ComunDB.ObtenerComando();
            comando.CommandText = consulta;
            comando.Parameters.AddWithValue("@Id", pEstado.Id);
            return ComunDB.EjecutarComando(comando);
        }
        public static List<Estado> ObtenerTodos()
        {
            string consulta = "SELECT TOP 500 e.Id, e.Nombre FROM Estado e";
            SqlCommand comando = ComunDB.ObtenerComando();
            comando.CommandText = consulta;
            SqlDataReader reader = ComunDB.EjecutarComandoReader(comando);
            List<Estado> listaEstados = new List<Estado>();
            while (reader.Read())
            {
                Estado estado = new Estado();
                estado.Id = reader.GetByte(0);
                estado.Nombre = reader.GetString(1);
                listaEstados.Add(estado);
            }
            return listaEstados;
        }
        public static Estado BuscarPorId(byte pId)
        {                 
            string consulta = "SELECT  e.Id,e.Nombre FROM Estado e WHERE e.Id = @Id";                    
            SqlCommand comando = ComunDB.ObtenerComando();
            comando.CommandText = consulta;
            comando.Parameters.AddWithValue("@Id", pId);           
            SqlDataReader reader = ComunDB.EjecutarComandoReader(comando);
            Estado estado = new Estado();
            while (reader.Read())
            {               
                estado.Id = reader.GetByte(0);
                estado.Nombre = reader.GetString(1);
            }
            return estado;
        }
    }
}
