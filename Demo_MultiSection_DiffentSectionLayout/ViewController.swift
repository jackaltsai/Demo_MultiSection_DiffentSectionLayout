//
//  ViewController.swift
//  Demo_MultiSection_DiffentSectionLayout
//
//  Created by 蔡忠翊 on 2021/9/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // 範例 2: 多個 section，每個 section 搭配不同的 NSCollectionLayoutSection 排版
//    分成多個 section，依據以下規則排版:
//    section number 偶數的 section
//    group 延水平方向排列，可水平滑動。
//    section number 奇數的 section
//    group 延垂直方向排列。
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = generateLayout()
    }
    
    func generateLayout() -> UICollectionViewLayout {
        
        UICollectionViewCompositionalLayout { [unowned self] section, environment in
            if section.isMultiple(of: 2) {
                return self.horizontalScrollLayoutSection
            } else {
                return self.verticalScrollLayoutSection
            }
        }
    }
    
    var horizontalScrollLayoutSection: NSCollectionLayoutSection {
        let space: Double = 10
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200), heightDimension: .absolute(318))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = space
        section.contentInsets = NSDirectionalEdgeInsets(top: space, leading: space, bottom: space, trailing: space)
        section.orthogonalScrollingBehavior = .continuous
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    var verticalScrollLayoutSection: NSCollectionLayoutSection {
        let space: Double = 10
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(143))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = space
        section.contentInsets = NSDirectionalEdgeInsets(top: space, leading: space, bottom: space, trailing: space)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func numberOfItemsInSections(in collection: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 15
        } else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section.isMultiple(of: 2) {
            print(indexPath.section)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(VerticalCollectionViewCell.self)", for: indexPath) as! VerticalCollectionViewCell
            cell.imageView.image = UIImage(named: "Image\(indexPath.item + 1)")
            cell.label.text = "Image\(indexPath.item + 1)"
            return cell
        } else {
            print(indexPath.section)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HorizontalCollectionViewCell.self)", for: indexPath) as! HorizontalCollectionViewCell
            cell.imageView.image = UIImage(named: "Product\(indexPath.item + 1)")
            cell.label.text = "Product\(indexPath.item + 1)"
            return cell
        }
        
    }
}
