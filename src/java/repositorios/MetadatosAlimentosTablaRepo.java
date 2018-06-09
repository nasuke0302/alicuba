/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import java.util.List;
import models.ListadoTablaGeneradas;
import models.MetadatosAlimentosTabla;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author Feisy
 */
public interface MetadatosAlimentosTablaRepo extends JpaRepository<MetadatosAlimentosTabla, Integer>{
    
    public List<MetadatosAlimentosTabla> findByIdListadoTablaGeneradas(ListadoTablaGeneradas ltg);
}
