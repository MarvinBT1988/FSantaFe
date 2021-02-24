using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FSantaFe.Facturacion.AccesoADatos;
using FSantaFe.Facturacion.EntidadesDeNegocio;

namespace FSantaFe.Facturacion.LogicaDeNegocio
{
 public class EstadoBL
 {
  public static int Guardar(Estado pEstado)
  {
   return EstadoDAL.Guardar(pEstado);
  }
  public static int Modificar(Estado pEstado) 
  {
   return EstadoDAL.Modificar(pEstado);
  }
  public static int Eliminar(Estado pEstado) 
  {
   return EstadoDAL.Eliminar(pEstado);
  }
  public static List<Estado> ObtenerTodos() 
  {
   return EstadoDAL.ObtenerTodos();
  }
  public static Estado BuscarPorId(byte pId) 
  {
   return EstadoDAL.BuscarPorId(pId);
  }
 }
}
