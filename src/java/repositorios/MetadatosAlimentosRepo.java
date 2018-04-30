/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import java.util.List;
import models.MetadatosAlimentosG;
import models.Referencias;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 *
 * @author albert
 */
@Repository
public interface MetadatosAlimentosRepo extends JpaRepository<MetadatosAlimentosG, Integer> {

    public MetadatosAlimentosG findByIdReferencia(Referencias referencia);

//    @Query("SELECT mat FROM MetadatosAlimentosG mat INNER JOIN Referencias r ON "
//            + "mat.idReferencia=r.idReferencia INNER JOIN TablaCnaGeneral tcg "
//            + "ON tcg.idMetadatosAlimentosG = mat.idMetadatosAlimentosG INNER JOIN "
//            + "Nutrientes n ON tcg.idNutriente = n.idNutriente WHERE r.idReferencia = ?1")
//    List<MetadatosAlimentosG> findEstudioByReferencia(Integer IdReferencia);
   
    @Query("SELECT mat FROM MetadatosAlimentosG mat WHERE mat.idReferencia = ?1")
    List<MetadatosAlimentosG> findEstudioByReferencia(Referencias IdReferencia);
    
    public MetadatosAlimentosG findTopByOrderByIdMetadatosAlimentosGDesc();
}