/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import java.util.List;
import models.Provincia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 *
 * @author albert
 */
@Repository
public interface ProvinciaRepo extends JpaRepository<Provincia, Integer>{
    
    @Query("SELECT p FROM Provincia p WHERE p.idProvincia=?1")
    public List<Provincia> getRegion(Integer IdProv);    
}