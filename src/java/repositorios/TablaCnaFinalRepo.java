/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import models.TablaCnaFinal;
import models.TablaCnaFinalPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 *
 * @author Feisy
 */
public interface TablaCnaFinalRepo extends JpaRepository<TablaCnaFinal, TablaCnaFinalPK>{
    
}
