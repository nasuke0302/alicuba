/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package repositorios;

import java.util.List;
import models.Alimentos;
import models.Usuarios;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author albert
 */
@Repository
public interface AlimentosRepo extends JpaRepository<Alimentos, Integer>{
    
    public List<Alimentos> findAllByIdUsuario(Usuarios u);
}