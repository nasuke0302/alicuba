/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import java.util.List;
import models.MetadatosAlimentosG;
import models.Nutrientes;
import models.TablaCnaGeneral;
import models.TablaCnaGeneralPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author albert
 */
public interface TablaCnaGeneralRepo extends JpaRepository<TablaCnaGeneral, TablaCnaGeneralPK>{
    
    @Query("SELECT t FROM TablaCnaGeneral t WHERE t.tablaCnaGeneralPK =?1 AND t.valor = ?2")
    public TablaCnaGeneral findThisRecord(TablaCnaGeneralPK cnaGeneralPK, Float valor);
	
    @Query("SELECT t FROM TablaCnaGeneral t WHERE t.metadatosAlimentosG =?1")
    public List<TablaCnaGeneral> getTabla_cna_general(MetadatosAlimentosG idMetadatosAlimentosG);
	
    @Query("SELECT t FROM TablaCnaGeneral t WHERE t.tablaCnaGeneralPK = ?1")
    public List<TablaCnaGeneral> getTabla_cna_general(TablaCnaGeneralPK cnaGeneralPK);
}
