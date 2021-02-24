using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FSantaFe.Facturacion.EntidadesDeNegocio;
using FSantaFe.Facturacion.AccesoADatos;

namespace FSantaFe.Facturacion.LogicaDeNegocio
{
 public class CargoBL
 {
  public static int Guardar(Cargo pCargo) 
  {
   return CargoDAL.Guardar(pCargo);
  }
  public static int Modificar(Cargo pCargo) 
  {
   return CargoDAL.Modificar(pCargo);
  }
  public static int Eliminar(Cargo pCargo)
  {
   return CargoDAL.Eliminar(pCargo);
  }
  public static List<Cargo> ObtenerTodos() 
  {
   return CargoDAL.ObtenerTodos();
  }  
  public static Cargo BuscarPorId(byte pId) 
  {
   return CargoDAL.BuscarPorId(pId);
  }
  public static List<Cargo> ObtenerHabilitados()
  {
   return CargoDAL.ObtenerHabilitados();
  }
  public static List<Cargo> Buscar(Cargo pCargo) 
  {
   return CargoDAL.Buscar(pCargo);
  }
 }
}
