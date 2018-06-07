/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import java.util.List;
import models.Alimentos;
import models.Calidad;
import models.Epocas;
import models.Fertilizado;
import models.MetadatosAlimentosG;
import models.NivelFert;
import models.Paises;
import models.RangoEdades;
import models.Referencias;
import models.Region;
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

    @Query("SELECT mat FROM MetadatosAlimentosG mat WHERE mat.idReferencia = ?1")
    List<MetadatosAlimentosG> findEstudioByReferencia(Referencias IdReferencia);
    
    public MetadatosAlimentosG findTopByOrderByIdMetadatosAlimentosGDesc();
    
    @Query("SELECT r FROM MetadatosAlimentosG r WHERE r.idAlimento=?1 and r.idRegion=?2")
    public List<MetadatosAlimentosG> metadatosAlimentosDeLaRegion(Alimentos idAlimento, Region idRegion);
    
    @Query("SELECT r FROM MetadatosAlimentosG r WHERE r.idAlimento=?1 and r.idRegion=?2 and r.idEpoca=?3 and r.idNivelFert=?4 and r.riego=?5 and r.n=?6 and r.npk=?7 and r.idRangoEdades=?8 and r.corte=?9 and r.tecnolog=?10 and r.tratamiento=?11 and r.presentation=?12 and r.calidad=?13 and r.import1=?14 and r.fertilizado=?15")
    public List<MetadatosAlimentosG> metadatosAlimentosDeLaRegion(
		Alimentos idAlimento, 
		Region idRegion, 
		Epocas idEpoca, 
		NivelFert idNivelFert, 
		MetadatosAlimentosG riego, 
		MetadatosAlimentosG n, 
		MetadatosAlimentosG npk, 
		RangoEdades idRangoEdades, 
		MetadatosAlimentosG corte,
		MetadatosAlimentosG tecnolog,	
		MetadatosAlimentosG tratamiento,
		MetadatosAlimentosG presentation,
		Calidad idCalidad,
		Paises import1,
		Fertilizado idFertilizado
		);
}