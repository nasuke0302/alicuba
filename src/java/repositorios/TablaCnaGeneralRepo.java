/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import models.TablaCnaGeneral;
import models.TablaCnaGeneralPK;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author albert
 */
public interface TablaCnaGeneralRepo extends JpaRepository<TablaCnaGeneral, TablaCnaGeneralPK>{
    
}
