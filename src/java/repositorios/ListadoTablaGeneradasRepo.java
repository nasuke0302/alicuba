/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import models.ListadoTablaGeneradas;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Feisy
 */
@Repository
public interface ListadoTablaGeneradasRepo extends JpaRepository<ListadoTablaGeneradas, Integer>{

    public ListadoTablaGeneradas findTopByOrderByIdListadoTablaGeneradasDesc();
}
