package com.tuempresa.gestionra.repository;

import com.tuempresa.gestionra.model.Criterio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CriterioRepository extends JpaRepository<Criterio, Integer> {
    List<Criterio> findByRaId(Integer raId);
}
