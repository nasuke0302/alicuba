/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import models.VariablesFormulas;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Tesis
 */
@Repository
public interface VariablesFormulasRepo extends JpaRepository<VariablesFormulas, Integer>{
    
}
