using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.Windows.Forms;

namespace FSantaFe.Facturacion.UI.WinForm.Utilidades
{
    public class UFormulario
    {
        public static int ObtenerIdGrid(DataGridView dataGridView) {
            try
            {
                int id = 0;
                id = int.Parse(dataGridView.Rows[dataGridView.CurrentRow.Index].Cells[0].Value.ToString());
                return id;
            }
            catch (Exception)
            {
                return 0;
            }
        }
    }
}
