<?php

namespace App\Controllers;
use App\Models\Modelpenjualan;

class Penjualan extends BaseController
{
    public function index()
    {
        $data = [
            'list-penjualan' => $this->penjualan->findAll()
        ];
        return view('penjualan/data_penjualan', $data);
    }

    public function tambahPenjualan()
    {
        $data = [
            'listPenjualan' => $this->penjualan->findAll(),
            
        ];
        return view('penjualan/tambah-penjualan', $data);
    }

    public function simpanPenjualan()
    {
        $data = [
            'kode_produk' => $this->produk->generateProductCode(),
            'nama_produk' => $this->request->getPost('nama_produk'),
            'harga_beli' => str_replace('.', '', $this->request->getPost('harga_beli')),
            'harga_jual' => str_replace('.', '', $this->request->getPost('harga_jual')),
            'diskon' => $this->request->getPost('diskon'),
            'katid' => $this->request->getPost('katid'),
            'satid' => $this->request->getPost('satid'),
            'stok' => $this->request->getPost('stok'),
        ];
        $this->produk->insert($data);
        return redirect()->to('/list-produk');
    }
}