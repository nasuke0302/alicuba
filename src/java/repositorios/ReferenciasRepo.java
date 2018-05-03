/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import models.Referencias;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author albert
 */
@Repository
public interface ReferenciasRepo extends JpaRepository<Referencias, Integer> {
    
    public Referencias findTopByOrderByIdReferenciaDesc();
}
