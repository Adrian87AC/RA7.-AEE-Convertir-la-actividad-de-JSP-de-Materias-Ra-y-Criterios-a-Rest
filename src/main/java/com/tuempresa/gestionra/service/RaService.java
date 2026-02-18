package com.tuempresa.gestionra.service;

import com.tuempresa.gestionra.model.Ra;
import com.tuempresa.gestionra.repository.RaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class RaService {

    @Autowired
    private RaRepository raRepository;

    public List<Ra> findAll() {
        return raRepository.findAll();
    }

    public List<Ra> findByMateriaId(Integer materiaId) {
        return raRepository.findByMateriaId(materiaId);
    }

    public Optional<Ra> findById(Integer id) {
        return raRepository.findById(id);
    }

    public Ra save(Ra ra) {
        return raRepository.save(ra);
    }

    public void deleteById(Integer id) {
        raRepository.deleteById(id);
    }
}
