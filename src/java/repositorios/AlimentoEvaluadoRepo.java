/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import java.util.List;
import models.AlimentoEvaluado;
import models.MetadatosAlimentosG;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author Feisy
 */
public interface AlimentoEvaluadoRepo  extends JpaRepository<AlimentoEvaluado, Integer>{
    //@Query("SELECT r FROM MetadatosAlimentosG r WHERE r.idAlimento=?1")
    //public List<MetadatosAlimentosG> metadatos_evaluado(Alimentos idAlimento, Region idRegion);
        
    @Query("SELECT a FROM AlimentoEvaluado a WHERE a.idMetadatosEvaluado = ?1")        
    public List<AlimentoEvaluado> MetadatosEvaluado(MetadatosAlimentosG IdMetadatosEvaluado);
}
