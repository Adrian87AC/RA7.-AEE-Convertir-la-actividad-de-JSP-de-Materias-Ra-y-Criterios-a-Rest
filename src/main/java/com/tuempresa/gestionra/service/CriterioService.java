package com.tuempresa.gestionra.service;

import com.tuempresa.gestionra.model.Criterio;
import com.tuempresa.gestionra.repository.CriterioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CriterioService {

    @Autowired
    private CriterioRepository criterioRepository;

    public List<Criterio> findAll() {
        return criterioRepository.findAll();
    }

    public List<Criterio> findByRaId(Integer raId) {
        return criterioRepository.findByRaId(raId);
    }

    public Optional<Criterio> findById(Integer id) {
        return criterioRepository.findById(id);
    }

    public Criterio save(Criterio criterio) {
        return criterioRepository.save(criterio);
    }

    public void deleteById(Integer id) {
        criterioRepository.deleteById(id);
    }
}
